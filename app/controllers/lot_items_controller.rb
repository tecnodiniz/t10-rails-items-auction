class LotItemsController < ApplicationController
  before_action :authenticate_administrator!

  def new 
    @lot = Lot.find(params[:lot_id])
    @lot_item = LotItem.new

  end

  def create
    @lot_item = LotItem.new(params.require(:lot_item).permit(:lot_id, :product_id))
    
    binding.pry
    
    if @lot_item.save

      
      
      
      redirect_to lots_all_path, notice: "Item adicionado ao lote: #{@lot.code}"
    else
      redirect_to lots_all_path, notice: 'Não há itens para adicionar'
    end
  end

  def destroy
    lot_item = LotItem.find(params[:id])
    lot = lot_item.lot

    if lot.aproved == 'aprovado'
      redirect_to view_items_path(lot.id), notice: 'Não é possível remover itens'
    else
      item = lot_item.item
      lot_item.destroy

      item.update(selected: false)

      redirect_to view_items_path(lot.id), notice: 'Item removido'

    end
  end
end
