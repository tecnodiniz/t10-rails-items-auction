class LotItemsController < ApplicationController
  before_action :authenticate_administrator!
  before_action :set_lot

  def new 
    @lot_item = LotItem.new

  end

  def create
    # return redirect_to lot_path(@lot),notice: 'Nenhum item foi adicionado' if params[:product_id].nil?
   
    @lot_item = LotItem.new(params.require(:lot_item).permit(:product_id).merge(lot: @lot))
    if @lot_item.save
      @lot_item.product.update(status: :selected)
      redirect_to lot_path(@lot), notice: "Item adicionado ao lote: #{@lot.code}"
    else
      flash.now[:notice] = 'Não foi possível adicionar item'
      render :new
    end
  end

  def destroy
    lot_item = LotItem.find(params[:id])
    lot_item.product.update(status: :available)
    lot_item.destroy

    redirect_to lot_path(@lot), notice: 'Item removido com sucesso'
    
  end

  private 

  def set_lot
    @lot = Lot.find(params[:lot_id])
  end
end
