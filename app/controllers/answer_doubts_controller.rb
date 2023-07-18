class AnswerDoubtsController < ApplicationController
  def new
    @answer_doubt = AnswerDoubt.new
  end

  def create
    @lot = Lot.find(params[:lot_id])

    @answer_doubt = answer
    if @answer_doubt.save
      send_message
      redirect_to lot_path(@lot), notice: t('.success')
    else
      redirect_to lot_path(@lot), notice: t('.failure')
    end
  end

  private

  def answer
    AnswerDoubt.new(answer: params[:answer], lot_doubt_id: params[:lot_doubt_id],
                    administrator: current_administrator)
  end

  def send_message
    doubt = LotDoubt.find(params[:lot_doubt_id])
    user =  User.find(doubt.user_id)
    UserMessage.create!(user:, from_email: current_administrator.email,
                        title: "Dúvida respondida. Lot: #{@lot.code}", message: "Sua dúvida foi respondida: #{params[:answer]}")
  end
end
