namespace :hera_cms do
  desc "Populates the production database with the generated YML seed"
  task populate_database: [:environment] do
    @file_path = File.join(Rails.root, 'db', 'hera_cms', 'hera_database_seed.yml')

    if File.exists?(@file_path)
      yaml = YAML.load(File.read(@file_path))

      models = [ HeraCms::Link, HeraCms::Text, HeraCms::Image ]

      models.each do |model|
        model_name = model.model_name.plural

        if yaml.key?(model_name)
          elements = yaml[model_name]
          elements.each do |identifier, element_params|
            element = model.find_or_initialize_by(identifier: element_params["identifier"])
            element.assign_attributes(element_params.without("identifier"))
            if element.valid?
              puts "#{model.to_s} - #{element.identifier} -> Saved successfully." if element.changed? && element.save
            else
              puts "#{model.to_s} - #{element.identifier} -> Not valid. #{element.errors.full_messages}"
            end
          end
        end
      end
    else
      fail StandardError, "HeraCms seed file not found. Please add some HeraCms records to your development database."
    end
  end
end

