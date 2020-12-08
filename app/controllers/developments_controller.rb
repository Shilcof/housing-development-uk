class DevelopmentsController < ApplicationController

  before "/developments*" do
    redirect_if_not_logged_in
  end

  # GET: /developments
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
    erb :"/developments/show.html"
  end

  # GET: /developments/5/edit
  get "/developments/:slug/edit" do
    redirect_if_not_developer
    @development = Development.find_by_slug(params[:slug])
    erb :"/developments/edit.html"
  end

  # PATCH: /developments/5
  patch "/developments/:slug" do
    @development = Development.find_by_slug(params[:slug])
    redirect "/developments/:id"
  end

  # DELETE: /developments/5/delete
  delete "/developments/:slug/delete" do
    @development = Development.find_by_slug(params[:slug])
    redirect "/developments"
  end

  private
  def redirect_if_not_developer
    if !current_user.developer
      redirect "/"
    end
  end
end
