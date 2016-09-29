class Event < ApplicationRecord
  belongs_to :group
  has_many :appointments, dependent: :destroy
  
  validates_presence_of :name
  validates_presence_of :deadline
  validates_presence_of :group_id

  def deadlinePassed?
    Time.now > deadline
  end

  def get_winner
    max = 0
    index = 0
    @event_results.each do |key, hash|
      if hash[:average] >= max
        max = hash[:average]
        index = key
      end
    end
    Appointment.find(index)
  end

  def get_results
    @event_results = {}
    appointments.each do |appointment|
      @event_results[appointment.id] = {average: appointment.get_average, number: appointment.get_number_of_voters}
    end
    @event_results
  end

end
