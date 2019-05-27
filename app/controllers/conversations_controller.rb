class ConversationsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_user_id_loggued, only: [:index]

    def index
        render json: Conversation.where("user_send_id = ? OR user_receive_id = ?", @user_id, @user_id)
    end

    def create
        conversation = Conversation.new(conversation_params)
        if conversation.valid?
            conversation.save
            serialized_data = ActiveModelSerializers::Adapter::Json.new(ConversationSerializer.new(conversation)).serializable_hash
            ActionCable.server.broadcast 'conversations_channel', serialized_data
            render json: {data: serialized_data}
        else 
            render json: {messages: conversation.errors.full_messages }, status: 422
        end
    end
    
    private

    def set_user_id_loggued
        @user_id = User.where(email: request.headers["uid"])[0].id
    end
    
    def conversation_params
        params.permit(:user_send_id, :user_receive_id)
    end
end
