class CreateAppointments < ActiveRecord::Migration[5.0]
  def change
    create_table :appointments do |t|
      t.string :action
      t.string :place
      t.datetime :time
      t.references :event, foreign_key: true

      t.timestamps
    end
  end
end
