class Event < ApplicationRecord
  belongs_to :group
  has_many :appointments

  def isDeadline?
    deadline > Time.now
  end
end
