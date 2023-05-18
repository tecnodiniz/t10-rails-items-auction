class LotsController < ApplicationController
    before_action :authenticate_user!, only: [:lots_all, :new, :create, :bid, :aprove, :index, :favorited]

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
        
        @lot = Lot.find(params[:id])
        if @lot.aproved == 'aprovado'
            @items = LotItem.where(lot_id: params[:id])
        

            if user_session
            @bid =  Bid.where(lot_id: params[:id], user_id: current_user.id).last
            end
        else
            redirect_to root_path
        end
    end

    def lots_all 
        if current_user.admin
            @lots = Lot.all
        else
            redirect_to new_user_session_path
        end
    
    end

    def expired 
        @lots = Lot.all
    end

    def aprove 

        @lot = Lot.find(params[:id])

        if !Aproved.where(lot_id: @lot.id).any?
            if current_user.id == @lot.user_id
                redirect_to lots_all_path, notice: 'Você não pode aprovar seu próprio lote'
            else
                Aproved.create!(user_id: current_user.id, lot_id: @lot.id, date_aproved: Date.today)

                @lot.update(aproved: true)
            
                redirect_to lots_all_path, notice: 'Lote aprovado'
            end 
        else
            redirect_to lots_all_path, notice: 'Este lote já está aprovado'

        end

    end

    def validate 
        
        if !Finalized.where(lot_id: params[:id]).any?
            lot = Lot.find(params[:id])
            winner =  Bid.where(lot_id: lot.id).last

            if winner 
                Finalized.create!(lot_id: winner.lot_id)
                Winner.create!(lot_id: winner.lot_id, user_id:winner.user_id)

                LotItem.where(lot_id: winner.lot_id).each do |i|
                    Sold.create!(item_id: i.id)
                end

                redirect_to expireds_path, notice: "O vencedor foi calculado: #{winner.user.email}."
            else
                Finalized.create!(lot_id: lot.id)

                LotItem.where(lot_id: lot.id).each do |i|
                    Item.find(i.item_id).update(selected: false)
                    i.destroy
                end
                redirect_to expireds_path, notice: "O lote foi finalizado"

            end
        else
            redirect_to expireds_path, notice: "Este lote já foi finalizado"

        end
    
    end

    def bid 
      
        @lot = Lot.find(params[:id])

        if @lot.limit_date < Date.today
            redirect_to lot_path(@lot), notice: 'Este leilão já foi encerrado '
        elsif @lot.start_date > Date.today
            redirect_to lot_path(@lot), notice: 'Este leilão não foi iniciado'
        else
            @bid = Bid.new
        end
    end

    def favorited
        
        if !Favorite.where(lot_id: params[:id], user_id: current_user.id).any?
            Favorite.create!(lot_id: params[:id], user_id: current_user.id)
            redirect_to lot_path(params[:id]), notice: 'Lote favoritado'
        else
            redirect_to lot_path(params[:id]), notice: 'Lote já favoritado'

        end
    end

end

