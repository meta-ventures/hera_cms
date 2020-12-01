class CreateHeraCmsHeraLinks < ActiveRecord::Migration[6.0]
  def change
    create_table :hera_cms_hera_links do |t|

      t.timestamps
    end
  end
end
