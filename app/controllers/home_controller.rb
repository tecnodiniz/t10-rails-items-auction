class HomeController < ApplicationController
  def index
    @lots = Lot.where(status: 'aproved')

    @user_messages = UserMessage.where(status: :unread, user: current_user).count
  end
end
