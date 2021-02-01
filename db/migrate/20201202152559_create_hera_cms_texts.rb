class CreateHeraCmsTexts < ActiveRecord::Migration[6.0]
  def change
    create_table :hera_cms_texts do |t|
      t.string :identifier
      t.string :inner_text
      t.string :classes
      t.string :style

      t.timestamps
    end
  end
end
