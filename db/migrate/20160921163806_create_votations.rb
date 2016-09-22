class CreateVotations < ActiveRecord::Migration[5.0]
  def change
    create_table :votations do |t|
      t.references :user, foreign_key: true
      t.references :appointment, foreign_key: true
      t.integer :result

      t.timestamps
    end
  end
end
