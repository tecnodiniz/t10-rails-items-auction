class RegistrationsController < Devise::RegistrationsController
  def create
    if email_domain_allowed?(params[:user][:email])
      super
    else
      flash[:alert] = 'O domínio @leilaodogalpao.com.br não é permitido.'
      redirect_to new_user_registration_path
    end
  end

  private

  def email_domain_allowed?(email)
    !email&.ends_with?('@leilaodogalpao.com.br')
  end
end
