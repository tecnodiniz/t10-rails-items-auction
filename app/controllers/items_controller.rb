class ItemsController < ApplicationController
    before_action :authenticate_user!, only:[:new, :create]
    def index 
        @item = Item.all
    end

    def new 
        @item = Item.new
    end

    def show 
        @item = Item.find(params[:id])
    end
    
    def create 
        @item = Item.new(params.require(:item).permit(:name,:url_img,:weight,:height,:width,:depth,:category_id))

        if @item.save 
            redirect_to items_path, notice: 'Item cadastrado com sucesso'
        else
            render 'new'
        end
    end


end