class User < ActiveRecord::Base
	has_many :seats

	def self.fetch_user_by_user_name(user_name)
		User.find_or_create_by(user_name: user_name) do |user|
			user.user_wallet_cents = 10000
		end
	end
end
