class TransactionsController < ApplicationController
  before_action :find_user

  def index
    if @user.group == 1
      @transactions = Transaction.where(:client_id => @user.id)
    else
      @transactions = Transaction.where(:teen_id => @user.id)
    end
  end


  def new
    @services = @user.services.select{ |s| s.service_users.any?}
  end

  def create
    @transaction = Transaction.new(transaction_params)
    @transaction.update_attributes(:teen_id => @user.id)
    service_user = Service.find_by_id(@transaction.service_id).service_users.first
    @transaction.update_attributes(:client_id => service_user.user_id)
    if @transaction.save
      redirect_to(user_path(current_user.id))
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
      redirect_to(user_transaction_path(@user.id, @transaction.id))
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
                                        :service_id, :client_id, :teen_id )
  end

end
