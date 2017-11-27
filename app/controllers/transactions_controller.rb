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
    service_jobs = @user.service_jobs.where(:status => 3 )
    services = @user.services.where(:status => 3)
    @services = services + service_jobs
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
    @services = @user.services.select{ |s| s.service_users.any?}
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

  def find_user
    if params[:user_id]
      @user = User.find(params[:user_id])
    end
  end

  def transaction_params
    params.require(:transaction).permit(:charge_per_hour, :total_amount, :number_of_hours, :service_title,
                                        :service_id, :client_id, :teen_id, :status )
  end

end
