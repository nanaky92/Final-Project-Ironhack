class CreateApiVotations < ActiveRecord::Migration[5.0]
  def change
    create_table :api_votations do |t|

      t.timestamps
    end
  end
end
