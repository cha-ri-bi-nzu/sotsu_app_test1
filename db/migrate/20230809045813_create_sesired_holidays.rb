class CreateSesiredHolidays < ActiveRecord::Migration[6.1]
  def change
    create_table :sesired_holidays do |t|
      t.date :select_holiday
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :sesired_holidays, :select_holiday
  end
end
