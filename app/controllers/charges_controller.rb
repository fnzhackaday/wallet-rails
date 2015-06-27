class ChargesController < ApplicationController
  before_action :authenticate_user!

  def new
    @amount = with_pence(params[:amount])
    @display_amount = params[:amount]
    Rails.cache.write("amount", @amount)
  end

  def create
    @amount = Rails.cache.read("amount")
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

    @charge = current_user.charges.create(amount: @amount)
    current_user.update(balance: new_balance)
    redirect_to root_path
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to root_path
  end
end
