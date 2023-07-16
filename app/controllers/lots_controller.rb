class LotsController < ApplicationController
  before_action :authenticate_administrator!, only: %i[new create index]
  before_action :set_lot, only: %i[edit show update aprove finish]
  before_action :check_available, only: %i[show]

  def index
    @lots = Lot.all
  end

  def show
    @bid = Bid.where(lot: @lot)
    @winner = Winner.where(lot: @lot).first if Winner.where(lot: @lot).present?

    return unless @bid.any?

    @user_bid = @bid.where(user: current_user).last
    @last_bid = @bid.last
  end

  def new
    @lot = Lot.new
  end

  def edit; end

  def create
    @lot = Lot.new(params_require)
    if @lot.save
      redirect_to lots_path, notice: t('.success')
    else
      flash.now[:notice] = t('.failure')
      render 'new'
    end
  end

  def update
    if @lot.update(params_require)

      redirect_to lot_path(@lot), notice: t('.success')
    else
      flash.now[:notice] = t('.failure')
      render :edit
    end
  end

  def aprove
    if @lot.update(status: :aproved)
      redirect_to lot_path(@lot), notice: t('.success')
    else
      flash.now[:notice] = t('failure')
      render :show
    end
  end

  def finish
    if @lot.update(status: :finished)
      redirect_to lot_path(@lot), notice: t('.success')
    else
      flash.now[:notice] = t('failure')
      render :show
    end
  end

  def finished
    @lots = Lot.where(status: %i[finished winned no_winner])
  end

  private

  def set_lot
    @lot = Lot.find(params[:id])
  end

  def params_require
    params.require(:lot).permit(:code, :start_date, :limit_date, :min_value, :dif_value).merge(
      administrator_id: current_administrator.id
    )
  end

  def check_available
    lot = Lot.find(params[:id])
    if current_administrator.present?
      if current_administrator.email.exclude?('@leilaodogalpao.com.br') && lot.awaiting?
        redirect_to root_path,
                    notice: t('.not_allowed')
      end

    elsif lot.awaiting?
      redirect_to root_path, notice: t('.not_allowed')
    end
  end
end
