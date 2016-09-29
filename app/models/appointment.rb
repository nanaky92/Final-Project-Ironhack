class Appointment < ApplicationRecord
  belongs_to :event
  has_many :votations, dependent: :destroy

  validates_presence_of :action
  validates_presence_of :place
  validates_presence_of :time

  def get_average
    votations.average(:result)
  end

  def get_number_of_voters
    accessed_app = votations.where(access: true)
    accessed_app ? accessed_app.length : 0
  end

  def get_users_who_wont_come
    users = []
    votations.where("result < ?", 25).each do |votation|
      users.push(votation.user)
    end
    users
  end

end
