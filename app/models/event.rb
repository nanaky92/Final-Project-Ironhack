class Event < ApplicationRecord
  belongs_to :group
  has_many :appointments, dependent: :destroy
  # has_many :votations, through: :appointments, dependent: :destroy

  def deadlinePassed?
    Time.now > deadline
  end

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

end
