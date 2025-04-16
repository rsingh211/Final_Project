ActiveAdmin.setup do |config|
    config.namespace :admin do |admin|
      admin.footer = proc do
        javascript_include_tag("rails-ujs")
      end
    end
  end
  