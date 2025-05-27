class AddUlidToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :ulid, :string
  end
end
