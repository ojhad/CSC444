class CardsController < ApplicationController

  def new
    @user = User.find(current_user.id)
  end

  # IF USER ALREADY HAS STRIPE ACCOUNT, THEN JUST MAKE THE ADDED CARD THE DEFAULT PAYMENT AND DELETE
  # ALL PREVIOUS CARDS ON STRIPE SYSTEM
  # ELSE CREATE A NEW STRIPE ACCOUNT FOR THE USER AND ADD THE CREDIT CARD DETAILS
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

    redirect_to user_cards_path(@user.id)

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

