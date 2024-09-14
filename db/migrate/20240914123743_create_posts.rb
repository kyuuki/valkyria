class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.datetime :posted_at
      t.string :status

      t.timestamps
    end
  end
end
