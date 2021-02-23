module HeraCms
  class ApplicationRecord < ActiveRecord::Base
    self.abstract_class = true
    before_save :update_seed

    def self.identify(identifier)
      self.find_by(identifier: identifier)
    end

    def editable?
      true
    end

    def update_seed
      model = self.class.model_name.plural
      file_name = "hera_database_seed.yml"
      directory_path = File.join(Rails.root, 'db', 'hera_cms')
      @file_path = File.join(directory_path, file_name)

      Dir.mkdir(directory_path) unless File.exists?(directory_path)

      elements = File.exists?(@file_path) ? YAML.load(File.read(@file_path)) : {}

      elements[model] = {} unless elements.key?(model)

      elements[model][self.identifier] = self.as_json.without("id", "created_at", "updated_at")


      File.open(@file_path, "w") { |file| file.write(elements.to_yaml) }
    end

  end
end
