class DevelopmentsController < ApplicationController

  before "/developments*" do
    redirect_if_not_logged_in
  end

  # GET: /developments ---------------------------
  get "/developments" do
    erb :"/developments/index.html"
  end

  get "/developments/new" do
    redirect_if_not_developer
    erb :"/developments/new.html"
  end

  post "/developments" do
    redirect_if_not_developer
    current_user.developments.build(params)
    if current_user.save
      redirect "/users/#{current_user.slug}"
    else
      redirect "/developments/new"
    end
  end

  get "/developments/:slug" do
    @development = Development.find_by_slug(params[:slug])
    @developer = @development.developer
    erb :"/developments/show.html"
  end

  get "/developments/:slug/edit" do
    redirect_if_not_developer
    @development = Development.find_by_slug(params[:slug])
    @developer = @development.developer
    redirect_if_wrong_developer(@developer)
    erb :"/developments/edit.html"
  end

  patch "/developments/:slug" do
    redirect_if_not_developer
    @development = Development.find_by_slug(params[:slug])
    @developer = @development.developer
    redirect_if_wrong_developer(@developer)
    if @development.update(params[:development])
      redirect "/developments/#{@development.slug}"
    else
      redirect "/developments/#{@development.slug}/edit"
    end
  end

  delete "/developments/:slug" do
    redirect_if_not_developer
    @development = Development.find_by_slug(params[:slug])
    @developer = @development.developer
    redirect_if_wrong_developer(@developer)
    @development.destroy
    redirect "/users/#{ current_user.slug }"
  end

  private
  def redirect_if_not_developer
    if !current_user.developer
      redirect "/"
    end
  end

  def redirect_if_wrong_developer(developer)
    if current_user != developer
      redirect "/"
    end
  end
end
