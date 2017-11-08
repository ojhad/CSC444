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
    @transaction.update_attributes(:total_amount => (@transaction.charge_per_hour * @transaction.number_of_hours))
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
