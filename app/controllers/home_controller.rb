class HomeController < ApplicationController
  def index
    @lots = Lot.where(status: 'aproved')
  end
end
