class FavoritesController < ApplicationController
  def index
    @lot = Favorite.where(user_id: current_user.id)
  end

  def favorite
    lot =  Lot.find(params[:id])
    user = User.find(params[:user_id])
    Favorite.create!(lot:, user:)
    redirect_to lot_path(lot), notice: t('.success')
  end

  def destroy; end
end
