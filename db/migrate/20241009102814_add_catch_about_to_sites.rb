class AddCatchAboutToSites < ActiveRecord::Migration[7.0]
  def change
    add_column :sites, :catch, :text
    add_column :sites, :about, :text
  end
end
