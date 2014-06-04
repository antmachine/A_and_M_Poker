class CreateSeats < ActiveRecord::Migration
  def change
    create_table :seats do |t|
      t.integer :user_id
      t.integer :match_id
      t.string :card1, limit: 2
      t.string :card2, limit: 2
      t.integer :user_pot_cents
      t.integer :bet_short_cents
      t.integer :position

      t.timestamps
    end
  end
end
