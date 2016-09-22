class Appointment < ApplicationRecord
  belongs_to :event
  has_many :votations
end
