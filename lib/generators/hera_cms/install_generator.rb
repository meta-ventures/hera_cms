require "rails/generators/active_record"

module HeraCms
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include ActiveRecord::Generators::Migration
      source_root File.join(__dir__, "templates")

      def copy_migration
        migration_template "install.rb", "db/migrate/install_hera.rb", migration_version: migration_version
      end

      def copy_config
        template "config.rb", "config/initializers/hera.rb"
      end

      def migration_version
        "[#{ActiveRecord::VERSION::MAJOR}.#{ActiveRecord::VERSION::MINOR}]"
      end
    end
  end
end
