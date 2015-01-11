class AddSharingToLinks < ActiveRecord::Migration
  def change
    add_column :links, :sharing, :boolean, default: false
  end
end
