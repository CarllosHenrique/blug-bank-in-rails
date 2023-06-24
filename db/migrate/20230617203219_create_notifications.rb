# db/migrate/timestamp_create_messages.rb
class CreateNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications do |t|
      t.references :sender, foreign_key: { to_table: :users }
      t.references :recipient, foreign_key: { to_table: :users }
      t.integer :amount

      t.timestamps
    end
  end
end
