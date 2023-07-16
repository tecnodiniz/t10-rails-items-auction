class UserMessagesController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @messages = UserMessage.where(user: @user)
  end
end
