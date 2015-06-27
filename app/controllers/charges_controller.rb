class ChargesController < ApplicationController
  before_action :authenticate_user!

  def new
  end

  def create
    @amount = 500
    old_balance = current_user.balance
    new_balance = old_balance + @amount

    customer = Stripe::Customer.create(
      :email => current_user.email,
      :card  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :description => 'Rails Stripe customer',
      :currency    => 'usd'
    )

    current_user.update(balance: new_balance)

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to charges_path
  end
end
