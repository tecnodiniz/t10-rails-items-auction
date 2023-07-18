class AnswerDoubtsController < ApplicationController
  def new
    @answer_doubt = AnswerDoubt.new
  end

  def create
    @lot = Lot.find(params[:lot_id])

    @answer_doubt = AnswerDoubt.new(answer: params[:answer], lot_doubt_id: params[:lot_doubt_id],
                                    administrator: current_administrator)

    if @answer_doubt.save
      redirect_to lot_path(@lot), notice: t('.success')
    else
      redirect_to lot_path(@lot), notice: t('.failure')
    end
  end
end
