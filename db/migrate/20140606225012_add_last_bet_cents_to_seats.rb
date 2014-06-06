class AddLastBetCentsToSeats < ActiveRecord::Migration
  def change
    add_column :seats, :last_bet_cents, :integer
  end
end
