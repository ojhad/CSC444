class CardsController < ApplicationController

  def new
    @user = User.find(current_user.id)
  end

  def create

    @user = User.find(current_user.id)

    if @user.stripe_id

      customer = Stripe::Customer.retrieve(@user.stripe_id)

      cards = Stripe::Customer.retrieve(customer.id).sources.all(:object => "card")

      customer.sources.retrieve(cards.data[0].id).delete

      customer.source = params[:stripeToken]

      customer.save

      flash.notice = "Card added successfully"

      redirect_to user_cards_path(@user.id)


    else

    customer = Stripe::Customer.create(
        :email => params[:stripeEmail],
        :source  => params[:stripeToken]
    )

    @user.stripe_id = customer.id
    @user.save

    flash.notice = "Card added successfully"
    redirect_to user_path(@user.id)

    end

  end

  def index

    @user = User.find(params[:user_id])

    @current_user = current_user


    if @current_user.id==@user.id

      cards = Stripe::Customer.retrieve(@user.stripe_id).sources.all(:object => "card")

      @cards = cards.data

    end



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


