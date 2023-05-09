class LotsController < ApplicationController
    before_action :authenticate_user!, only: [:lots_all]

    def index 
        @lots = Lot.all
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

