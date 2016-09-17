class AddAdminToGroups < ActiveRecord::Migration[5.0]
  def change
    add_reference :groups, :admin, references: :user, foreign_key: true
  end
end
