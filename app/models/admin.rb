class Admin < ApplicationRecord
  belongs_to :user
  has_one :group
end
