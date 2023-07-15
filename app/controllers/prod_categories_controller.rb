class ProdCategoriesController < ApplicationController
  def index
    @categories = ProdCategory.all
  end

  def new
    @category = ProdCategory.new
  end

  def create
    @category = ProdCategory.new(params.require(:prod_category).permit(:description))

    if @category.save
      redirect_to prod_categories_path, notice: t('.success')
    else
      flash.now[:notice] = t('.failure')
      render :new
    end
  end
end
