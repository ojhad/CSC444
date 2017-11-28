class TransactionsController < ApplicationController
  before_action :find_user

  def index
    if @user.is_teen?
     @transactions = @user.teen_transactions
    else
      @transactions = @user.client_transactions
    end
  end


  def new
    find_services
  end

  def create
    @transaction = Transaction.new(transaction_params)
    @transaction.update_attributes(:teen_id => @user.id, :status => :teen_approved)
    client_id = Service.find_by_id(@transaction.service_id).user_id
    client = User.find_by_id(client_id)
    @transaction.update_attributes(:client_id => client_id)
    if @transaction.save
      client.notifications.create title: "#{@user.first_name} #{@user.last_name} has created a new transaction that needs your approval",
                                   reference_user_id: @user.id,
                                   user_id: client,
                                   read: FALSE
      redirect_to(user_path(@user.id))
    else
      flash.error = @transaction.errors
      render :new
    end
  end

  def show
    @transaction = Transaction.find(params[:id])
  end

  def edit
    find_services
    @transaction = Transaction.find(params[:id])
  end

  def update
    @transaction = Transaction.find(params[:id])
    @transaction.update_attributes(transaction_params)
    if @transaction.save
      if @user.is_teen?
        client = User.find_by_id(@transaction.client_id)
        client.notifications.create title: "#{@user.first_name} #{@user.last_name} has updated the transaction",
                                  reference_user_id: @user.id,
                                  user_id: client,
                                  read: FALSE
      else
        teen = User.find_by_id(@transaction.teen_id)
        if @transaction.status == 'client_approved'
          teen.notifications.create title: "#{@user.first_name} #{@user.last_name} has approved your transaction",
                                      reference_user_id: @user.id,
                                      user_id: teen,
                                      read: FALSE
          params = {:amount => @transaction.total_amount * 100, :service_id => @transaction.service_id, :service_name => @transaction.service_title}
          charge_card(params)
          redirect_to user_charges_path(@user.id)
          return
        else
          teen.notifications.create title: "#{@user.first_name} #{@user.last_name} has requested changes to the transaction",
                                    reference_user_id: @user.id,
                                    user_id: teen,
                                    read: FALSE
        end
      end
      flash['notice'] = 'Updated transaction'
      redirect_to(user_transactions_path(@user.id))
    else
      flash.error = @transaction.errors
      render :edit
    end
  end

  private

  def find_user
    if params[:user_id]
      @user = User.find(params[:user_id])
    end
  end

  def transaction_params
    params.require(:transaction).permit(:charge_per_hour, :total_amount, :number_of_hours, :service_title,
                                        :service_id, :client_id, :teen_id, :status )
  end

  def find_services
    service_jobs = @user.service_jobs.where(:status => 3 )
    services = @user.services.where(:status => 3)
    @services = services + service_jobs
  end

  def charge_card(params)

    customer = @user
    # 14 % charge
    amount = (params[:amount] * 1.14).round

    @charge = Stripe::Charge.create(
    :amount => amount,
    :currency => "cad",
    :customer => customer.stripe_id,
    :description => "Charge for " + params[:service_id].to_s + ": " + params[:service_name]
    )
    if @charge['failure_code'].present?
      flash[:error] = "Credit card charge failed: #{@charge['failure_message']}"
      redirect_to(user_transaction_path(@user.id, @transaction.id))

    end
    @db_charge = Charge.new(:user_id => @user.id,
                            :amount => amount.to_f / 100,
                            :stripe_charge_id => @charge.id)

    @db_charge.save!

    year = @db_charge.created_at.year
    month = @db_charge.created_at.month

    @finance = Finance.where(month: month , year: year).first

    payout = @db_charge.amount * (100.to_f / 114.to_f)
    credit_card_fee = @db_charge.amount * 0.02
    profit = @db_charge.amount * 0.12

    if @finance.blank?
      @finance_entry = Finance.new(:month => month ,
                                   :year => year,
                                   :total_amount => @db_charge.amount,
                                   :payout => payout,
                                   :credit_card_fee => credit_card_fee,
                                   :profit => profit )
      @finance_entry.save!
    else
      @finance.total_amount = @finance.total_amount + @db_charge.amount
      @finance.payout = @finance.payout + payout
      @finance.credit_card_fee = @finance.credit_card_fee + credit_card_fee
      @finance.profit = @finance.profit + profit
      @finance.save!
    end

    @transaction.update_attributes(:status => 'completed')
    service = Service.find_by_id( @transaction.service_id)

    # Update states after payments are completed
    @transaction.update_attributes(:status => 'completed')
    service.update_attributes(:status => 4)

    # If you will explicitly let the customer submit a form before paying then you can use the below for redirecting
    # If the charge is implicit, then I don't think a notice or redirect is required
    flash.notice = "Your credit card has been charged successfully."

  end

end
