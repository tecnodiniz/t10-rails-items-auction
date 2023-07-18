class UserMessagesController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @messages = UserMessage.where(user: @user)
  end

  def show
    @message =  UserMessage.find(params[:id])
    @message.update(status: :read)
  end
end
