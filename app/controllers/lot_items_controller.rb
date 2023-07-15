class LotItemsController < ApplicationController
  before_action :authenticate_administrator!
  before_action :set_lot

  def new
    @lot_item = LotItem.new
    return redirect_to lot_path(@lot) unless Product.where(status: :available).any?
  end

  def create
    @lot_item = LotItem.new(params.require(:lot_item).permit(:product_id).merge(lot: @lot))
    if @lot_item.save
      @lot_item.product.update(status: :selected)
      redirect_to lot_path(@lot), notice: "Item adicionado ao lote: #{@lot.code}"
    else
      flash.now[:notice] = t('.failure')
      render :new
    end
  end

  def destroy
    lot_item = LotItem.find(params[:id])
    lot_item.product.update(status: :available)
    lot_item.destroy

    redirect_to lot_path(@lot), notice: t('.success')
  end

  private

  def set_lot
    @lot = Lot.find(params[:lot_id])
  end
end
