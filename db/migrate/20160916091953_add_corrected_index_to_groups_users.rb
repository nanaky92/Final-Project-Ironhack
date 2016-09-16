class AddCorrectedIndexToGroupsUsers < ActiveRecord::Migration[5.0]
  def change
    remove_index :groups_users, [nil, nil]
    add_index :groups_users, [:group_id, :user_id], :unique => true

  end
end