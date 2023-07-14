class AdministratorsController < ApplicationController
  def index
    @admins = Administrator.all
    @users = User.all
  end

  def new
    @admin = Administrator.new
  end

  def create_admin
    @admin = Administrator.new(params.require(:administrator).permit(:email, :password, :password_confirmation,
                                                                     :password, :cpf))

    if @admin.save
      redirect_to administrators_path, notice: t('.success')
    else
      flash.now[:notice] = t('.failure')
      render :new
    end
  end
end
