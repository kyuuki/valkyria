class CreateSites < ActiveRecord::Migration[7.0]
  def change
    create_table :sites do |t|
      t.string :host
      t.string :name
      t.string :template

      t.timestamps
    end
  end
end
