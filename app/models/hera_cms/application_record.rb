module HeraCms
  class ApplicationRecord < ActiveRecord::Base
    self.abstract_class = true
    def self.identify(identifier)
      self.find_by(identifier: identifier)
    end

    def update_json
      element = read_json
      element["#{self.identifier}"] = self.as_json.without("id", "created_at", "updated_at")
      save_json(element)
    end

    def read_json
      JSON.parse(File.read(File.join(Rails.root, 'db', 'seed', "#{self.class}.json")))
    end

    def save_json(element)
      filepath = File.join(Rails.root, 'db', 'seed', "#{self.class}.json")
      File.open(filepath, 'wb') do |file|
        file.write(JSON.generate(element))
      end
    end
  end
end
