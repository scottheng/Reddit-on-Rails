class Undo < ActiveRecord::Migration
  def change
    remove_column :posts, :sub_ids
    add_column :posts, :sub_id, :integer, null: false
  end
end
