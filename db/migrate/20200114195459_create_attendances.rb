class CreateAttendances < ActiveRecord::Migration[6.0]
  def change
    create_table :attendances do |t|
        t.integer :attendee_id, foreign_key: true, null: false
        t.integer :event_id, foreign_key: true, null: false
        t.timestamps
      end
      add_index :attendances, :event_id
      add_index :attendances, :attendee_id
  end
end
