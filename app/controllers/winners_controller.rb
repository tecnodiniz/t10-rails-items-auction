class WinnersController < ApplicationController
  before_action :set_lot, only: %i[calc]
  def index
    @winners = Winner.all
  end

  def calc
    if Bid.where(lot: @lot).present?
      set_user
      Winner.create!(user: @user, lot: @lot)
      @lot.update(status: :winned)
      redirect_to finished_lots_path, notice: message
    else
      @lot.update(status: :ended)
      redirect_to finished_lots_path, notice: t('.no_winner')
    end
  end

  private

  def set_lot
    @lot = Lot.find(params[:id])
  end

  def set_user
    @user = Bid.where(lot: @lot).last.user
  end

  def message
    "Ganhador: #{@user.email} - valor: R$#{@user.bids.last.value}"
  end
end
