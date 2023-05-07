class LotsController < ApplicationController

    def index 
        @lots = Lot.all
    end

    def show 

    end

    def lots_all 
        @lots = Lot.all
    end
end