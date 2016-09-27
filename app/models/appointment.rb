class Appointment < ApplicationRecord
  belongs_to :event
  has_many :votations

  def self.get_winner appointments_result
    max = 0
    index = 0
    appointments_result.each do |key, hash|
      if hash[:average] >= max
        max = hash[:average]
        index = key
      end
    end
    Appointment.find(index)
  end

  def get_average
    votations.average(:result)
  end

  def get_number_of_voters
    accessed_app = votations.where(access: true)
    accessed_app ? accessed_app.length : 0
  end

  def get_users_who_wont_come
    users = []
    votations.where("result < ?", 20).each do |votation|
      users.push(votation.user)
    end
    users
  end

end
