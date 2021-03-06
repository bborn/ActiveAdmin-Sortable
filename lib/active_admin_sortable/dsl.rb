module ActiveAdmin
  module SortableDSL
    extend ActiveSupport::Concern
    
    included do
      
      class_eval do
        def sortable(property, options={}, &block)
          
          config.sort_order = "#{property}_asc"
          
          controller.class.send :include, ActiveAdmin::SortableDSL::PageConfigurations
          
          _action_name = "sort_#{property.to_s.underscore}"
          _update_action_name = "update_#{_action_name}"
          options[:update_action] = _update_action_name
          options[:property] = property
          
          controller.prepend_view_path File.join File.expand_path("../../", File.dirname(__FILE__)), 'app/views'

          # Configure the sort page for the resource
          options[:as] ||= :table
          config.set_page_presenter :sort, ActiveAdmin::PagePresenter.new(options, &block)
          
          # Creates the button in the top right corner.
          action_item :except => _action_name.to_sym do
            link_to "Order #{property.to_s.titleize}", url_for(:action => _action_name)
          end
          action_item :only => _action_name.to_sym do
            link_to "Done Ordering #{property.to_s.titleize}", url_for(:action => :index)
          end

          # Adds the :get action at /sort
          collection_action _action_name, :method => :get do
            render active_admin_template('sort.html.arb'), :layout => nil
          end
          # Adds the :post action at /sort
          collection_action _update_action_name, :method => :post do
            ids = params[resource_class.to_s.underscore]
            ids.each_index do |index|
              instance = resource_class.find(ids[index])
              instance.send(:attributes=, { options[:property].to_sym => index })
              instance.save!
            end
            
            render :nothing => true
          end
        end        
        
      end
      
    end    

    module PageConfigurations
      extend ActiveSupport::Concern
    
      included do
        # helper_method :sort_config
      end

      module ClassMethods
        [:sort].each do |page|
          # eg: index_config
          define_method :"#{page}_config" do
            get_page_presenter(page)
          end

          # # eg: reset_index_config!
          # define_method :"reset_#{page}_config!" do
          #   reset_page_config! page
          # end
        end
      end
      
      def sort_config
        @sort_config ||= self.class.sort_config
      end
      
    end



  end
end

ActiveAdmin::ResourceDSL.send :include, ActiveAdmin::SortableDSL
Dir[File.expand_path('../views', __FILE__) + "/**/*.rb"].sort.each{ |f| require f }
ActiveAdmin.application.view_factory.register :sort_page => ActiveAdmin::Views::Pages::Sort