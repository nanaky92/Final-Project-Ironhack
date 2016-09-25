class Group < ApplicationRecord
  has_and_belongs_to_many :users
  belongs_to :admin, dependent: :destroy
  has_many :invitations, dependent: :destroy
  has_many :events

  def isUserAdmin?(current_user)
    current_user == admin.user
  end

end
