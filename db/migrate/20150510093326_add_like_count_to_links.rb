class AddLikeCountToLinks < ActiveRecord::Migration
  def change
    add_column :links, :like_count, :integer
  end
end
