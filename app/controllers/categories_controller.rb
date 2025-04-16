class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
    @beats = @category.beats.order(created_at: :desc).page(params[:page]).per(10)
  end
end
