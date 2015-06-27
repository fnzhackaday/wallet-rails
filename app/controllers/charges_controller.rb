class ChargesController < ApplicationController
  before_action :authenticate_user!


  def new
    @amount = params[:amount]
    Rails.cache.write("amount", params[:amount])
  end

  def create
    @amount = Rails.cache.read("amount").to_i
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

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to charges_path
  end
end
