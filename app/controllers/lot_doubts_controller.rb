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

      redirect_to lot_path(@lot), notice: t('.failure')
    end
  end

  private

  def set_lot
    @lot = Lot.find(params[:lot_id])
  end
end
