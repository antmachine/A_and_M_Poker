class MatchesController < ApplicationController
	before_action :require_login, except: [:login]
	def index
	end

	def play
		# Join the match
		@match = Match.find_and_join_available_match(@user)
	end

	def in_game_ajax
		client_json_string = request.POST[:ajax_json_data]
		client_json = JSON.parse client_json_string
		json_response = Match.process_client_json(client_json, @user)
		render json: json_response
	end

	def login
		if request.post?
			user_name = request.POST[:user_name]
			user = User.fetch_user_by_user_name(user_name)
			session[:user_id] = user.id
			redirect_to action: "index"
		end	
	end

	def logout
		session.delete :user_id
		redirect_to action: "login"
	end

	private
	def require_login
		user_id = session[:user_id]
		@user = User.find_by_id(user_id)
		if @user.nil?
			redirect_to action: "login"
		end
	end
end
