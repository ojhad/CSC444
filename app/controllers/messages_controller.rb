class MessagesController < ApplicationController
  before_action do
    conversation_id = params[:conversation_id] || params[:message][:conversation_id]
    sender_id = params[:sender_id] || params[:message][:sender_id]
    recipient_id = params[:recipient_id] || params[:message][:recipient_id]
    puts sender_id
    puts recipient_id
    if not conversation_id
      conversation = Conversation.between(sender_id, recipient_id)
      if conversation.present?
        @conversation = conversation_id.first
      else
        @conversation = Conversation.create({sender_id: sender_id, recipient_id: recipient_id})
      end
    else
      @conversation = Conversation.find(params[:conversation_id])
    end
  end

  def index
    @messages = @conversation.messages
    if @messages.length > 5
      @over_5 = true
      @messages = @messages[-5..-1]
    end
    if params[:m]
      @over_5 = false
      @messages = @conversation.messages
    end
    if @messages.last
      if @messages.last.user_id != current_user.id
        @messages.last.read = true
      end
    end
    @message = @conversation.messages.new
  end

  def new
    puts "NIGGA WE MADE IT"
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
    params.require(:message).permit(:body, :user_id)
  end
end
