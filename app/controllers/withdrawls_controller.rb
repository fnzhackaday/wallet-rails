class WithdrawlsController < ApplicationController
	skip_before_action :verify_authenticity_token

	def create
		@withdrawl = current_user.withdrawls.new(amount: params[:amount].to_i)
		if @withdrawl.save
			old_balance = current_user.balance
	    new_balance = old_balance - params[:amount].to_i
	    current_user.update(balance: new_balance)
	   else
	   	'No'
	   end

    redirect_to root_path
	end

end
