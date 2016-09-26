class Event < ApplicationRecord
  belongs_to :group
  has_many :appointments

  def deadlinePassed?
    Time.now > deadline
  end
end
