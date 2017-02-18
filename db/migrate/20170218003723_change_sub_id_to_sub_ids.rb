class ChangeSubIdToSubIds < ActiveRecord::Migration
  def change
    remove_column :posts, :sub_id
    add_column :posts, :sub_ids, :integer, array: true, default: []
  end
end
