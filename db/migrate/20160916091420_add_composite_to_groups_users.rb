class AddCompositeToGroupsUsers < ActiveRecord::Migration[5.0]
  def change
    add_index :groups_users, [:groups, :users], :unique => true
  end
end