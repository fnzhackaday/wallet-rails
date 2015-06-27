class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def with_pence(amount)
    amount.to_i * 100
  end

  def without_pence(amount)
    amount / 100
  end
end
