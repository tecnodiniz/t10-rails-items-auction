class AdministratorsController < ApplicationController

  def index 
    @admins = Administrator.all
    @users = User.all
  end
  
  def new 
    @admin = Administrator.new
  end

  def create_admin
    @admin = Administrator.new(params.require(:administrator).permit(:email, :password,:password_confirmation, :password, :cpf))
    
    if @admin.save
      redirect_to administrators_path, notice: 'Administrador cadastrado com sucesso'
    else
      flash.now[:notice] = 'Erro, não foi possível criar administrador'
      render :new
    end
  end
end