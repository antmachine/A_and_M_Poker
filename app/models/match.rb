class Match < ActiveRecord::Base
	has_many :seats

	BUY_IN_CENTS = 2000

	def self.find_and_join_available_match(user)
		# TODO limit number of users to number of possible dealing cards
		match = Match.where(active_seat_id: nil).take
		if match.nil?
			match = Match.create(pot_cents: 0, num_cards_showing: 0)
		end
		match.user_join(user)
		return match
	end

	def self.process_client_json(client_json, user)
		match = Match.find(client_json[:match_id])
		seat = Seat.where(match_id: client_json[:match_id], user_id: client_json[:user_id]).take
		case client_json[:action]
		when "client_start_match"
			match.client_start_match(seat)
		when "client_bet"
			match.client_bet(seat, client_json[:bet_cents])
		when "client_fold"
			match.client_fold(seat)
		when "client_poll"
			match.client_poll(seat)
		end
	end

	private
	def user_join(user)
		# TODO check if user_wallet_cents >= BUY_IN_CENTS
		# TODO check that user hasn't already joined this match in a different seat
		user.user_wallet_cents = user_wallet_cents - BUY_IN_CENTS
		user.save!
		last_seat_to_join = Seat.where(match_id: self.id).order(postion: :desc).first
		if last_seat_to_join.nil?
			position = 0
		else
			position = last_seat_to_join.position + 1
		end
		Seat.create(user_id: user.id, match_id: self.id, user_pot_cents: BUY_IN_CENTS, bet_short_cents: 0, position: position, last_bet_cents: 0)
	end

	def client_start_match(seat)
		self.active_seat_id = 0
		all_cards = []
		suit_array = %w(C D H S)
		number_array = %w(A 2 3 4 5 6 7 8 9 0 J Q K)
		suit_array.each do |suit|
			number_array.each do |number|
				all_cards.push(number + suit)
			end
		end
		all_cards.shuffle!
		self.card1 = all_cards.pop
		self.card2 = all_cards.pop
		self.card3 = all_cards.pop
		self.card4 = all_cards.pop
		self.card5 = all_cards.pop
		self.seats.each do |s|
			s.card1 = all_cards.pop
			s.card2 = all_cards.pop
			s.save!
		end
		save!
	end

	def client_bet(seat, bet_cents)
		#TODO implement
	end

	def client_fold(seat)
		#TODO ensure seat is active seat
		seat.user.user_wallet_cents += seat.user_pot_cents
		seat.user_pot_cents = 0
		seat.last_bet_cents = nil
		seat.save!
		seat.user.save!
		self.active_seat_id = get_next_active_seat(seat).id
		self.save!
		#TODO if betting is done for this round (turn/river/flop), deal more cards and set the right next player, and if its the last round determine who has won
	end

	def client_poll(seat)
		seat_array = self.seats.order(position: :acd).map do |s|
			{
				"user_name" => s.user.user_name,
				"user_pot_cents" => s.user_pot_cents,
				"bet_short_cents" => s.bet_short_cents,
				"last_bet_cents" => s.last_bet_cents,
				"their_turn" => s.id == self.active_seat_id
			}
		end
		your_hand = [seat.card1, seat.card2]
		visible_cards = [self.card1, self.card2, self.card3, self.card4, self.card5].take(self.num_cards_showing)
		your_turn = self.active_seat_id == seat.id
		pot_cents = self.pot_cents
		{
			"seats" => seat_array,
			"your_hand" => your_hand,
			"visible_cards" => visible_cards,
			"your_turn" => your_turn,
			"pot_cents" => pot_cents
		}
	end

	def get_next_active_seat(seat)
		max_position = Seat.where(match_id: self.id).order(position: :desc).first.position
		if seat.position == max_position
			next_seat_position = 0
		else
			next_seat_position = seat.postion + 1
		end
		return Seat.where(match_id: self.id, position: next_seat_position).take
	end
end

