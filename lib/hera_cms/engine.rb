module HeraCms
  class Engine < ::Rails::Engine
    isolate_namespace HeraCms

    # initialize "hera_cms.load_app_instance_data" do |app|
    #   HeraCms.setup do |config|
    #     config.app_root = app.root
    #   end
    # end

    # initialize "hera_cms.load_static_assets" do |app|
    #   app.middleware.use ::ActionDispatch::Static, "#{root}/public"
    # end
  end
end
