class CreateShifts < ActiveRecord::Migration[6.1]
  def change
    create_table :shifts do |t|
      t.date :working_day
      t.integer :working_status_id
      t.time :working_time
      t.time :leaving_time
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    add_index :shifts, :working_day
    add_index :shifts, :working_status_id
  end
end
