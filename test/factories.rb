FactoryGirl.define do
  factory :admin_user do
    email 'admin@example.com'
    password "test123"
    password_confirmation {|u| u.password }
  end
  
  Factory.sequence :page_name do |n|
    "Page#{n}" 
  end
  
  Factory.sequence :position do |n|
    n
  end
  
  factory :page do
    name {  Factory.next(:page_name) }
    position { Factory.next(:position) - 1}
    body "Body Text"
  end  
  
end