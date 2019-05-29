class ConversationsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_user_id_loggued, only: [:index, :create, :users_for_new_conversations]

    def index
        render json: Conversation.get_conversations_user_loggued(@user_id)
    end

    def create
        conversation = Conversation.new(conversation_params)
        if conversation.valid?
            conversation.save
            ActionCable.server.broadcast "conversations_channel_#{conversation_params[:user_send_id]}",
                conversation: Conversation.parse_conversation_with_user_third(conversation, @user_id)
            ActionCable.server.broadcast "conversations_channel_#{conversation_params[:user_receive_id]}",
                conversation: Conversation.parse_conversation_with_user_third(conversation, @user_id)
            render json: { data: conversation }
        else 
            render json: { messages: conversation.errors.full_messages }, status: 422
        end
    end

    def users_for_new_conversations
        render json: {
            data: Conversation.users_for_new_conversations(@user_id)
        }, status: 200
    end
    
    private

    def set_user_id_loggued
        @user_id = User.where(email: request.headers["uid"])[0].id
    end
    
    def conversation_params
        params.permit(:user_send_id, :user_receive_id)
    end
end
