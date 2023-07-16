class WinnersController < ApplicationController
  def index
    @winners = Winner.all
  end

  def calc
    lot = Lot.find(params[:id])
    user = Bid.where(lot:).last.user
    Winner.create!(user:, lot:)

    redirect_to finished_lots_path, notice: "Vencedor calculado\n Ganhador: #{user.email}"
  end
end
