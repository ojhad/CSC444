class CardsController < ApplicationController

  def new
    @user = User.find(current_user.id)
  end

  def create
    # Amount in cents
    # @amount = 500

    customer = Stripe::Customer.create(
        :email => params[:stripeEmail],
        :source  => params[:stripeToken]
    )

    @user = User.find(current_user.id)

    @user.stripe_id = customer.id
    @user.save

    flash.notice = "Card added successfully"
    redirect_to user_path(@user.id)
  end



end


=begin
    charge = Stripe::Charge.create(
        :customer    => customer.id,
        :amount      => @amount,
        :description => 'Rails Stripe customer',
        :currency    => 'usd'

    )


  rescue Stripe::CardError => e
    flash[:error] = e.message
  end

=end


