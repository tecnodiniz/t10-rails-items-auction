class BlockedCpfsController < ApplicationController
  def new
    @blocked_cpf = BlockedCpf.new
  end

  def create
    user = User.find_by(cpf: params[:cpf])
    @blocked_cpf = BlockedCpf.new(params_require)
    @blocked_cpf.merge(user:) if user.presence

    if @blocked_cpf.save
      redirect_to administrators_path, notice: t('.success')
    else
      flash.now[:notice] = t('.failure')
      render :new
    end
  end

  private

  def params_require
    params.require(:blocked_cpf).permit(:cpf)
  end
end
