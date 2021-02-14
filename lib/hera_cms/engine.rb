module HeraCms
  class Engine < ::Rails::Engine
    isolate_namespace HeraCms

    config.generators do |g|
      g.test_framework :rspec
      g.fixture_replacement :factory_bot
      g.factory_bot dir: 'spec/factories'
    end
    # initializer "hera_cms.load_app_instance_data" do |app|
    #   HeraCms.setup do |config|
    #     config.app_root = app.root
    #   end
    # end

    initializer "hera_cms.load_helpers" do |app|
      ActiveSupport.on_load(:action_view) { include HeraCms::TagHelper }
    end

    initializer "hera_cms.assets.precompile" do |app|
      if defined?(Sprockets) && Sprockets::VERSION >= "4"
        app.config.assets.precompile << "hera_cms/application.js"
        app.config.assets.precompile << "hera_cms/application.css"
        app.config.assets.precompile << "hera_cms/hera_white.png"
      else
        # use a proc instead of a string
        app.config.assets.precompile << proc { |path| path =~ /\Ahera_cms\/application\.(js|css)\z/ }
        app.config.assets.precompile << proc { |path| path =~ /\Ahera_cms\/.+\.(eot|svg|ttf|woff|woff2)\z/ }
        app.config.assets.precompile << proc { |path| path == "hera_cms/hera_white.png" }
      end
    end

  end
end
