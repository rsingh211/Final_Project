class BeatsController < InheritedResources::Base

  def index
    @beats = Beat.all
  end

  def show
    @beat = Beat.find(params[:id])
  end

  private

  def beat_params
    params.require(:beat).permit(:title, :description, :genre, :price, :license_type)
  end

end
