class UsersController < ApplicationController
  before_action :authenticate_user!
  def index; end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params.require(:user).permit(:email, :password, :password_confirmation,
                                                  :cpf).merge(admin: false))

    return unless email_domain_allowed?(@user.email)

    if @user.save
      redirect_to users_path, notice: t('.success')
    else
      flash.now[:notice] = t('.alert')
      render 'new'
    end
  end

  private

  def email_domain_allowed?(email)
    !email&.ends_with?('@leilaodogalpao.com.br')
  end
end
