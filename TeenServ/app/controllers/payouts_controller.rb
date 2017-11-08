class PayoutsController < ApplicationController

  def new
    @user = User.find(current_user.id)
  end


  def create

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

    @user = User.find(current_user.id)

    #@user.balance = 10.0

    @new_payout = Payout.new({:user_id => @user.id, :batch_id => @payout_batch.batch_header.payout_batch_id,
                             :amount => @user.balance})

    @new_payout.save

    @user.balance = 0.0

    flash.notice = "Payout successful"

    redirect_to user_payouts_path(@user.id)


  end
end
