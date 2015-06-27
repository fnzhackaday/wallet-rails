class TransactionsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!

  def create
    @amount = with_pence(params[:amount])
    @recipient = User.where(email: params[:recipient_id]).first
    @transaction = current_user.transactions.create(amount: @amount, recipient_id: @recipient.id)
      recipient_old_balance = @recipient.balance
      recipient_new_balance = recipient_old_balance + @transaction.amount
      @recipient.update(balance: recipient_new_balance)
      old_balance = current_user.balance
      new_balance = old_balance - @transaction.amount
      current_user.update(balance: new_balance)
    redirect_to root_path
  end

end
