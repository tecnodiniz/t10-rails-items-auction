class BidsController < ApplicationController

    def create 

        @bid = Bid.new(params.require(:bid).permit(:lot_id, :value).merge(user_id: current_user.id))
        lot = @bid.lot
        dif = lot.min_value

        if Bid.all.any?
            if @bid.value - Bid.where(lot_id:lot.id).last.value >= lot.dif_value
                if @bid.save
                    redirect_to lot_path(lot.id), notice: 'Lance efetuado com sucesso'
                else
                    redirect_to root_path, notice: 'Falha ao efetuar lance'
                end
            else
                redirect_to make_bid_path(lot.id), notice: 'O lance deve ser maior ou igual ao valor mínimo'
            end
        else
            if  @bid.value >= lot.min_value 
                if @bid.save
                    redirect_to lot_path(lot.id), notice: 'Lance efetuado com sucesso'
                else
                    redirect_to root_path, notice: 'Falha ao efetuar lance'
                end
            else
                redirect_to make_bid_path(lot.id),notice: 'O lance deve ser maior ou igual ao valor mínimo'
            end
        end
        
    end
end