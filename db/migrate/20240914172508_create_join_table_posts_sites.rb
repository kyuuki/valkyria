class CreateJoinTablePostsSites < ActiveRecord::Migration[7.0]
  def change
    create_join_table :posts, :sites do |t|
      t.index [:post_id, :site_id]
      t.index [:site_id, :post_id]
    end
  end
end
