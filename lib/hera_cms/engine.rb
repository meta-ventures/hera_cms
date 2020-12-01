module HeraCms
  class Engine < ::Rails::Engine
    isolate_namespace HeraCms

    initializer "hera_cms" do |app|
      # if defined?(Sprockets) && Sprockets::VERSION >= "4"
      #   app.config.assets.precompile << "hera_cms/application.js"
      #   app.config.assets.precompile << "hera_cms/application.css"
      #   app.config.assets.precompile << "hera_cms/glyphicons-halflings-regular.eot"
      #   app.config.assets.precompile << "hera_cms/glyphicons-halflings-regular.svg"
      #   app.config.assets.precompile << "hera_cms/glyphicons-halflings-regular.ttf"
      #   app.config.assets.precompile << "hera_cms/glyphicons-halflings-regular.woff"
      #   app.config.assets.precompile << "hera_cms/glyphicons-halflings-regular.woff2"
      #   app.config.assets.precompile << "hera_cms/favicon.png"
      # else
      #   # use a proc instead of a string
      #   app.config.assets.precompile << proc { |path| path =~ /\Ahera_cms\/application\.(js|css)\z/ }
      #   app.config.assets.precompile << proc { |path| path =~ /\Ahera_cms\/.+\.(eot|svg|ttf|woff|woff2)\z/ }
      #   app.config.assets.precompile << proc { |path| path == "hera_cms/favicon.png" }
      # end


      # HeraCms.s3_bucket = HeraCms.settings["s3_bucket"] if HeraCms.settings["s3_bucket"]
      HeraCms.cache ||= Rails.cache

      HeraCms.s3_bucket = HeraCms.settings["s3_bucket"] || ENV["HERA_CMS_S3_BUCKET"]
    end
  end
end
