class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :set_user_id_loggued, only: [:index]

    def index
        render json: User.where("id != ?", @user_id)
    end

    private

    def set_user_id_loggued
        @user_id = User.where(email: request.headers["uid"])[0].id
    end
end
