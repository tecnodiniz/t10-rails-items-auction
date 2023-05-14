class LotItemsController < ApplicationController
    before_action :authenticate_user!


    def index 
        @items = LotItem.where(lot_id: params[:id])
        @lot = Lot.find(params[:id])

        if @lot.aproved == "aprovado"
    
            log =  Aproved.find_by(lot_id: params[:id])
            @user = log.user
        end

    end
    
    def create 
        
        @lot_item = LotItem.new(params.require(:lot_item).permit(:lot_id, :item_id))

        if @lot_item.item
            @item = @lot_item.item
        end
            @lot = @lot_item.lot
        
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

    def destroy
        lot_item = LotItem.find(params[:id])
        lot =  lot_item.lot
     
        if lot.aproved == "aprovado"
            redirect_to view_items_path(lot.id), notice: "Não é possível remover itens"
        else
            item = lot_item.item
            lot_item.destroy

           
            item.update(selected: false)

            redirect_to view_items_path(lot.id), notice: "Item removido"
    
        end

    end

end