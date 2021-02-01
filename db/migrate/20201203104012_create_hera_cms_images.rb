class CreateHeraCmsImages < ActiveRecord::Migration[6.0]
  def change
    create_table :hera_cms_images do |t|
      t.string :identifier
      t.string :upload
      t.string :url
      t.string :classes
      t.string :style

      t.timestamps
    end
  end
end
