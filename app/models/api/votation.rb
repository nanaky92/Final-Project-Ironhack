class Api::Votation < ApplicationRecord
  def isDeadline?(deadline_time)
    deadline_time > Time.now
  end
end
