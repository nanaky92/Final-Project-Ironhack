class ChangeDeadlineFromEvents < ActiveRecord::Migration[5.0]
  def change
    change_table :events do |t|
      t.change :deadline, :datetime
    end  
  end
end
