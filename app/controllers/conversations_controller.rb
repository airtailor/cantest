class ConversationsController < ApplicationController
  before_action :logged_in
  load_and_authorize_resource


  def index
   @users = User.all
   @conversations = Conversation.all
  end

  def create
   if Conversation.between(params[:sender_id],params[:recipient_id])
     .present?
      @conversation = Conversation.between(params[:sender_id],
       params[:recipient_id]).first
   else
     @conversation = Conversation.create!(conversation_params)
   end
   redirect_to conversation_messages_path(@conversation)
  end

  private

  def logged_in
    if !current_user
      redirect_to "/users/sign_in"
    end
  end

   def conversation_params
    params.permit(:sender_id, :recipient_id)
   end
end
