class CreateGroupsUsersTable < ActiveRecord::Migration[5.0]
  def change
    create_table :groups_users, id: false do |t|
      t.references :group
      t.references :user
    end
  end
end
