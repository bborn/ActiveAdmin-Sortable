module ActiveAdmin
  module Views
    module Pages

      class Sort < Index

        def title
          # "Sort " + active_admin_config.plural_resource_name
          "Sort"
        end
        
        def config
          active_admin_config.get_page_presenter(:sort) || default_index_config
        end
        
        

        def render_index
          renderer_class = find_index_renderer_class(config[:as])
        
        #   paginated_collection(collection, :entry_name => active_admin_config.resource_name) do
            div :class => 'index_content sortable', "data-on-update" => url_for(config[:update_action]) do
              insert_tag(renderer_class, config, collection)
            end
        #   end
        end

      end
    end
  end
end

