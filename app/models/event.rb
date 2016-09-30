class Event < ApplicationRecord
  belongs_to :group
  has_many :appointments, dependent: :destroy
  
  validates_presence_of :name
  validates_presence_of :deadline
  validates_presence_of :group_id

  validate :deadline_date_cannot_be_in_the_past

  def deadline_date_cannot_be_in_the_past
    if deadline.present? && deadline < Time.now
      errors.add(:deadline, "can't be in the past")
    end
  end    

  def deadlinePassed?
    Time.now > deadline
  end

  def get_winner_id
    max = 0
    index = 0
    @event_results.each do |key, hash|
      if hash[:average] >= max
        max = hash[:average]
        index = key
      end
    end
    index == 0 ? -1 : index
  end

  def get_results
    @event_results = {}
    appointments.each do |appointment|
      @event_results[appointment.id] = {average: appointment.get_average, number: appointment.get_number_of_voters}
    end
    @event_results
  end

end
