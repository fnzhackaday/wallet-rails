class WelcomeController < ApplicationController
  before_action :authenticate_user!

	def index
    @balance = without_pence(current_user.balance)
	end
end
