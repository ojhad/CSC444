class MessagesController < ApplicationController
  before_action do
    conversation_id = params[:conversation_id] || params[:message] && params[:message][:conversation_id]
    sender_id = params && params[:sender_id] || params[:message] && params[:message][:sender_id]
    recipient_id = params && params[:recipient_id] || params[:message] && params[:message][:recipient_id]
    puts sender_id
    puts recipient_id
    if not conversation_id
      conversation = Conversation.between(sender_id, recipient_id)
      if conversation.present?
        @conversation = conversation.first
      else
        @conversation = Conversation.create({sender_id: sender_id, recipient_id: recipient_id})
      end
    else
      @conversation = Conversation.find(params[:conversation_id])
    end
  end
  def mark_as_read
    @messages = Message.order( 'created_at' )
    @messages.update_all(updated_at: Time.zone.now, read: true)
    render json: {success: true}
  end
  def index
    @messages = @conversation.messages.order( 'created_at' )
    @sent_by_other = @conversation.sender_id == current_user.id ? @conversation.recipient_id : @conversation.sender_id
    #puts request.original_url
    respond_to do |format|
      format.html { Message.mark_messages_as_read(@messages.unread_by_me(@sent_by_other))}
      format.json { render :index}
    end
  end
  def new
    # @message = @conversation.messages.new
  end

  def create
    @message = @conversation.messages.new(message_params)
    if @message.save
      redirect_to conversation_messages_path(@conversation)
    end
  end

  private
  def message_params
    if params[:sender_id]
      params.delete :sender_id
    end
    if params[:recipient_id]
      params.delete :recipient_id
    end
    params.require(:message).permit(:body, :user_id)
  end
end
