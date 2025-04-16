class PagesController < ApplicationController
  def show
    @page = Page.find_by(title: params[:id])

    if @page.nil?
      redirect_to root_path, alert: "Page not found"
    end
  end
end
