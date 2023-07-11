class HomeController < ApplicationController
  def index
    @lots = Lot.where(aproved: true)
  end
end
