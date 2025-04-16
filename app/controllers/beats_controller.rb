class BeatsController < InheritedResources::Base
  def index
    @categories = Category.all
    @beats = Beat.all

    # 🔍 Keyword Search
    if params[:query].present?
      @beats = @beats.where("LOWER(title) LIKE :q", q: "%#{params[:query].downcase}%")
    end
    

    # 📁 Filter by Category
    if params[:category_id].present?
      @beats = @beats.where(category_id: params[:category_id])
    end

    # 🕒 Filter by Status
    case params[:filter]
    when 'new'
      @beats = @beats.where("created_at >= ?", 3.days.ago)
    when 'recently_updated'
      @beats = @beats.where("updated_at >= ?", 3.days.ago).where.not("created_at >= ?", 3.days.ago)
    end

    @beats = @beats.order(created_at: :desc).page(params[:page]).per(10)
  end

  def show
    @beat = Beat.find(params[:id])
  end

  private

  def beat_params
    params.require(:beat).permit(:title, :description, :genre, :price, :license_type, :category_id)
  end
end
