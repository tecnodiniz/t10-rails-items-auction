class SessionsController < Devise::SessionsController
  before_action :check_block, only: %i[create]

  private

  def check_block
    user = User.find_by(email: params[:user][:email])
    return unless user.present?
      cpf = user.cpf
      return unless BlockedCpf.exists?(cpf:)

      flash[:alert] = t('.blocked')
      redirect_to new_user_session_path
    end
end

