class Votation < ApplicationRecord
  belongs_to :user
  belongs_to :appointment
end
