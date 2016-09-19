class AddAdminToGroups < ActiveRecord::Migration[5.0]
  def change
    add_reference :groups, :admin_id, references: :user, foreign_key: true
  end
end
