class AttendedEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :attended_events do |t|
      t.references :attendee, null: false, foreign_key: { to_table: :users }, index: true
      t.references :attended_event, null: false, foreign_key: { to_table: :events }, index: true
    end
  end
end
