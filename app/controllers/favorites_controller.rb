class FavoritesController < ApplicationController
    def index 
        @lot = Favorite.where(user_id: current_user.id)
    end
end
