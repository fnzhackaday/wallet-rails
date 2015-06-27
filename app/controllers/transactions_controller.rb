class TransactionsController < ApplicationController
  def new
    @transaction = Transaction.new
  end

  def create
    @transaction = current_user.transactions.new(transaction_params)
    if @transaction.save
      recipient = User.where(email: @transaction.recipient_email).first
      recipient_old_balance = recipient.balance
      recipient_new_balance = recipient_old_balance + @transaction.amount
      recipient.update(balance: recipient_new_balance)
      old_balance = current_user.balance
      new_balance = old_balance - @transaction.amount
      current_user.update(balance: new_balance)
    else
      "No"
    end
    redirect_to new_transaction_path
  end

  def transaction_params
    params.require(:transaction).permit(:amount, :recipient_email)
  end
end
