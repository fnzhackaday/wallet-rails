class WithdrawlsController < ApplicationController
	skip_before_action :verify_authenticity_token
	before_action :authenticate_user!

	def create
		@amount = with_pence(params[:amount])
		@withdrawl = current_user.withdrawls.new(amount: @amount)
		if @withdrawl.save
			old_balance = current_user.balance
	    new_balance = old_balance - @amount
	    current_user.update(balance: new_balance)
	   else
	   	'No'
	   end

    redirect_to root_path
	end

end
