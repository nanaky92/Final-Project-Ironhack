class Event < ApplicationRecord
  belongs_to :group
  has_many :appointments
end
