def show
  @page = Page.find_by(title: params[:id].capitalize)
end
