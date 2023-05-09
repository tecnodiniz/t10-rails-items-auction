class LotItemsController < ApplicationController
    before_action :authenticate_user!
    def index 
        @items = LotItem.where(lot_id: params[:id])
        @lot = Lot.find(params[:id])
    end
    
    def create 
        
        @lot_item = LotItem.new(params.require(:lot_item).permit(:lot_id, :item_id))

        if @lot_item.item_id
            @item = Item.find(@lot_item.item_id)
        end
            @lot = Lot.find(@lot_item.lot_id)
        
        if @lot_item.save 
           
            @item.update(selected: true)

            redirect_to lots_all_path, notice: "Item adicionado ao lote: #{@lot.code}"
        else
            redirect_to lots_all_path, notice: "Não há itens para adicionar"
        end

    end

    def add_item
       @lot_item = LotItem.new
       
       if Lot.find(params[:id]).aproved == "aprovado"
            redirect_to lots_all_path, notice: "Não é possível adicionar itens"
       end
       

    end

end