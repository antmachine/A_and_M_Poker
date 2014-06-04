class CreateMatchEvents < ActiveRecord::Migration
  def change
    create_table :match_events do |t|
      t.integer :match_id
      t.integer :seat_id
      t.integer :bet_cents

      t.timestamps
    end
  end
end
