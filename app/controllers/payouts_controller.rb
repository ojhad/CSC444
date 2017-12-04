class PayoutsController < ApplicationController

  def new
    @user = User.find(current_user.id)
  end

  # CREATE NEW PAYPAL PAYOUT FROM TEENSERV TO THE CLIENT
  # THE EMAIL BELOW IS THE SAME FOR ALL CLIENTS FOR TESTING DEMONSTRATION PURPOSES
  # PAYOUT AMOUNT IS ALSO A SET AMOUNT SINCE THE PAYPAL TEST ACCOUNT DOESN'T HAVE UNLIMITED FUNDS AND IT
  # TAKES AGES TO ADD FUNDS TO A TEST PAYPAL ACCOUNT. THEIR API SUCKS

  def index
    @user = User.find(current_user.id)
    @user_payouts = Payout.where(user_id:@user.id)
  end
  def create

    @user = User.find(current_user.id)
    @payout_info = @user.payout_information

    if @payout_info.method == 'paypal'
      @payout = PayPal::SDK::REST::Payout.new({
                                                  :sender_batch_header => {
                                                      :sender_batch_id => SecureRandom.hex(8),
                                                      :email_subject => 'You have a Payout from Teenserv!'
                                                  },
                                                  :items => [
                                                      {
                                                          :recipient_type => 'EMAIL',
                                                          :amount => {
                                                              :value => '0.5',
                                                              :currency => 'CAD'
                                                          },
                                                          :note => 'Thanks for your services!',
                                                          :sender_item_id => '2014031400023',
                                                          :receiver => 'teenserv444-buyer@gmail.com'
                                                      }
                                                  ]
                                              })
      begin
        @payout_batch = @payout.create(true)
        logger.info "Created Payout with [#{@payout_batch.batch_header.payout_batch_id}]"
      rescue PayPal::SDK::REST::ResourceNotFound => err
        logger.error @payout.error.inspect
      end

      @new_payout = Payout.new({:user_id => @user.id, :batch_id => @payout_batch.batch_header.payout_batch_id,
                                :method => 'paypal' , :amount => @user.balance})

      @new_payout.save!

      @user.balance = 0.0

      flash.notice = "Payout successful"

    else

      @new_payout = Payout.new({:user_id => @user.id, :batch_id => nil, :method => 'check',
                                :amount => @user.balance})

      @new_payout.save!

      @user.balance = 0.0

      flash.notice = "Check will be mailed within 7-10 business days!"

    end

    if(@payout_info.blank?)
      redirect_to user_path(@user.id)
    else
      redirect_to user_payouts_path(@user.id)
    end

  end
end
