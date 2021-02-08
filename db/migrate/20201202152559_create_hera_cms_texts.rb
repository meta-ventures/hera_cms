class CreateHeraCmsTexts < ActiveRecord::Migration[6.0]
  def change
    create_table :hera_cms_texts do |t|
      t.string :identifier
      t.string :inner_text, default: ""
      t.string :classes, default: ""
      t.string :style, default: ""

      t.timestamps
    end
  end
end
