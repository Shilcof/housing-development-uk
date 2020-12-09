
class DevelopersController < ApplicationController

  before "/developers*" do
    redirect_if_not_logged_in
  end

  get "/developers" do
    erb :"/developers/index.html"
  end

  get "/developers/:slug" do
    if params[:slug] != ""
      erb :error
    end
    if @developer = User.find_by_slug(params[:slug])
      erb :"/developers/show.html"
    else
      erb :error
    end
  end
end
