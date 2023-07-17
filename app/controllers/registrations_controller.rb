class RegistrationsController < Devise::RegistrationsController
  def create
    return redirect_to new_user_registration_path, notice: t('.blocked') unless check_block?(params[:user][:cpf])

    if email_domain_allowed?(params[:user][:email])
      super
    else
      flash[:alert] = t('.alert')
      redirect_to new_user_registration_path
    end
  end

  private

  def check_block?(cpf)
    !BlockedCpf.exists?(cpf:)
  end

  def email_domain_allowed?(email)
    !email&.ends_with?('@leilaodogalpao.com.br')
  end
end
