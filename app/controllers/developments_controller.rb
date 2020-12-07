class DevelopmentsController < ApplicationController

  # GET: /developments
  get "/developments" do
    erb :"/developments/index.html"
  end

  # GET: /developments/new
  get "/developments/new" do
    erb :"/developments/new.html"
  end

  # POST: /developments
  post "/developments" do
    redirect "/developments"
  end

  # GET: /developments/5
  get "/developments/:id" do
    @development = Development.find_by(params)
    erb :"/developments/show.html"
  end

  # GET: /developments/5/edit
  get "/developments/:id/edit" do
    erb :"/developments/edit.html"
  end

  # PATCH: /developments/5
  patch "/developments/:id" do
    redirect "/developments/:id"
  end

  # DELETE: /developments/5/delete
  delete "/developments/:id/delete" do
    redirect "/developments"
  end
end
