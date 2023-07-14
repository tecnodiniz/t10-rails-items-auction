class BidsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_lot, only: %i[new create]
  def new
    @bid = Bid.new
  end

  def create
    @bid = Bid.new(params_require)

    if @bid.save
      redirect_to lot_path(@lot), notice: t('.success')
    else
      flash[:notice] = t('.failure')
      render :new
    end
  end

  private

  def set_lot
    @lot = Lot.find(params[:lot_id])
  end

  def params_require
    params.require(:bid).permit(:value).merge(lot: @lot, user: current_user)
  end
end
