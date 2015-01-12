class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :content
      t.integer :user_id
      t.integer :link_id

      t.timestamps null: false
    end
    add_index :comments, :link_id
  end
end
