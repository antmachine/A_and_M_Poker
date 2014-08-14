# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

General
- Ante and talbe buy in


Client to Server
- Start the match (whenever ready)
	{"action": "client_start_match", "match_id": 123}
- Bet or fold
	{"action": "client_bet", "match_id": 123, bet_cents": 100}
	{"action": "client_fold", "match_id": 123}
- Client Poll
	{"action": "client_poll", "match_id": 123}


Server to Client 
{
	"seats": [
    {"user_name": "Mike", "user_pot_cents": 2000, "bet_short_cents": 0, "last_bet_cents": 100, "their_turn": false}
	],
	"your_hand": ["AC", KC"],
	"visible_cards": ["JC", "QC", "0C"],
	"your_turn": false,
	"pot_cents": 10000,
}



Steps to glory
Design Protocol
Tests back-end
Write back-end code
Write front-end code