class ProductsController < ApplicationController
  before_action :set_product, only: %i[show edit update]

  def index
    @products = Product.all
  end
  
  def show;end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    
    if @product.save
      redirect_to products_path, notice: t('.success')
    else
      flash.now[:alert] = t('.failure')
      render :new
    end
  end

  def edit;end

  def update
    
    if @product.update(product_params)
      redirect_to product_path(@product), notice: t('.success')
    else
      flash.now[:alert] = t('.failure')
      render edit
    end
  end

  private

  def set_product 
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :width, :height, :weight, :depth, :logo, :prod_category_id)
  end

end