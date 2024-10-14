class CreatePostmeta < ActiveRecord::Migration[7.0]
  def change
    create_table :postmeta do |t|
      t.references :post, null: false, foreign_key: true
      t.string :meta_key
      t.string :meta_value

      t.timestamps
    end
  end
end
