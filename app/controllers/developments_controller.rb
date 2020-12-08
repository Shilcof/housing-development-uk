class DevelopmentsController < ApplicationController

  before "/developments*" do
    redirect_if_not_logged_in
  end

  # GET: /developments
  get "/developments" do
    erb :"/developments/index.html"
  end

  get "/developments/new" do
    erb :"/developments/new.html"
  end

  post "/developments" do
    binding.pry
    redirect "/developments"
  end

  get "/developments/:slug" do
    @development = Development.find_by_slug(params[:slug])
    erb :"/developments/show.html"
  end

  # GET: /developments/5/edit
  get "/developments/:slug/edit" do
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
end
