class ConversationsController < ApplicationController
  def index
    @users = User.all
    @conversations = Conversation.all
    @current_user = current_user

    @convos = Conversation.user_conversations(current_user.id)
  end

  def create
    conversation = Conversation.between(params[:sender_id], params[:recipient_id])
    if conversation.present?
      @conversation = conversation.first
    else
      @conversation = Conversation.create!(conversation_params)
    end
    redirect_to conversation_messages_path(@conversation)
  end

  private
    def conversation_params
      params.permit(:sender_id, :recipient_id)
    end
end
