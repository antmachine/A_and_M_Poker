class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.integer :pot_cents
      t.string :card1, limit: 2
      t.string :card2, limit: 2
      t.string :card3, limit: 2
      t.string :card4, limit: 2
      t.string :card5, limit: 2
      t.integer :active_seat_id
      t.integer :num_cards_showing

      t.timestamps
    end
  end
end
