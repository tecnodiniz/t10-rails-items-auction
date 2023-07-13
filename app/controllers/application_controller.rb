class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |user_params|
      user_params.permit({ admin: [] }, :email, :password, :password_confirmation, :cpf)
      
    end
    devise_parameter_sanitizer.permit(:sign_up) do |administrator_params|
      administrator_params.permit(:email, :password, :password_confirmation, :cpf)
    end
  end

  def authenticate_administrator!
    unless current_administrator
      flash[:alert] = 'Acesso não autorizado.'
      redirect_to root_path
    end
  end
  
end
