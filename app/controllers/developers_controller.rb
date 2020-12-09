
class DevelopersController < ApplicationController

  get "/developers/:slug" do
    redirect_if_not_logged_in
    if params[:slug] != ""
      erb :error
    end
    if @developer = User.find_by_slug(params[:slug])
      erb :"/developers/show.html"
    else
      erb :error
    end
  end

  private
  def redirect_if_logged_in
    if logged_in?
      redirect "/developments"
    end
  end
end
