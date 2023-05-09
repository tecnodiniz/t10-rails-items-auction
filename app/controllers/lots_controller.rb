class LotsController < ApplicationController
    before_action :authenticate_user!, only: [:lots_all, :new, :create]

    def index 
        @lots = Lot.all
    end
    def new 
        @lot = Lot.new
    end

    def create 
        @lot = Lot.new(params.require(:lot).permit(:code,:start_date, :limit_date, :min_value, :dif_value).merge(
            user_id: current_user.id))

        if @lot.save 
            redirect_to lots_all_path, notice: 'Lote criado com sucesso'
        else
       
            render 'new'
        end
        
    end
    def show 

    end

    def lots_all 
        @lots = Lot.all
    end

    def aprove 

        @lot = Lot.find(params[:id])

        if current_user.id == @lot.user_id
            redirect_to lots_all_path, notice: 'Você não pode aprovar seu próprio lote'
        else
            @lot.update(aproved: true)
        
            redirect_to lots_all_path, notice: 'Lote aprovado'
        end 


    end

end

