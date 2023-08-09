class CreateShifts < ActiveRecord::Migration[6.1]
  def change
    create_table :shifts do |t|
      t.date :working_day
      t.references :user, null: false, foreign_key: true
      t.integer :working_status_id
      t.time :working_time

      t.timestamps
    end
  end
end
