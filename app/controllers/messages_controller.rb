class MessagesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_user_id_loggued, only: [:create]

    def create
        message = Message.new(message_params)

        if message.valid?
            conversation = Conversation.find(message_params[:conversation_id])
            #message.user_send_id = @user_id
            message.save
            serialized_data = ActiveModelSerializers::Adapter::Json.new(MessageSerializer.new(message)).serializable_hash
            MessagesChannel.broadcast_to conversation, serialized_data
            render json: {data: serialized_data}
        else
            render json: {messages: message.errors.full_messages }, status: 422
        end
    end
    
    private
    
    def message_params
        params[:user_send_id] = @user_id
        params.permit(:text, :conversation_id, :user_send_id)
    end

    def set_user_id_loggued
        @user_id = User.where(email: request.headers["uid"])[0].id
    end
end
