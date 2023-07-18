class LotDoubtsController < ApplicationController
  before_action :set_lot, only: %i[create]

  def new
    @doubt = LotDoubt.new
  end

  def create
    @doubt = LotDoubt.new(doubt: params[:doubt], lot: @lot, user: current_user)

    if @doubt.save
      redirect_to lot_path(@lot), notice: t('.success')
    else
      flash.now[:notice] = t('.failure')
      render lot_path(@lot)
    end
  end

  private

  def set_lot
    @lot = Lot.find(params[:lot_id])
  end
end
