class ChargesController < ApplicationController

  #This action expects a form that passes the following:
  # - amount: amount to be charged in cents
  # - service_name: name of completed service
  # - service_id : id of completed service

  def index
    @user = User.find(current_user.id)
    @charges = @user.charges
  end

  def create

    customer = User.find(params[:id])

    @charge = Stripe::Charge.create(
        :amount => params[:amount],
        :currency => "cad",
        :customer => customer.stripe_id,
        :description => "Charge for " + params[:service_id] + ": " + params[:service_name]
    )

    @db_charge = Charge.new(:user_id => params[:id], :amount => amount , :stripe_charge_id => @charge.id)

    @db_charge.save!

    year = @db_charge.created_at.year
    month = @db_charge.created_at.month

    @finance = Finance.where(month: month , year: year)

    if @finance.blank?
      @finance_entry = Finance.new(:month => month , :year => year, :amount => @db_charge.amount)
      @finance_entry.save!
    else
      @finance.amount = @finance.amount + @db_charge.amount
      @finance.save!
    end

    # If you will explicitly let the customer submit a form before paying then you can use the below for redirecting
    # If the charge is implicit, then I don't think a notice or redirect is required
    flash.notice = "Your credit card has been charged successfully."

    redirect_to user_charges_path(customer.id)

  end
end
