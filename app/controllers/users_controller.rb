class UsersController < ApplicationController

  # Sign up - log out
  get "/users/signup" do
    redirect_if_logged_in
    erb :"users/new.html"
  end

  post "/users/signup" do
    redirect_if_logged_in
    
    user = User.new(params)
    if user.save
      session[:user_id] = user.id
      redirect "/"
    else
      redirect "/users/signup"
    end
  end

  get "/users/login" do
    redirect_if_logged_in
    erb :"users/login.html"
  end

  post "/users/login" do
    redirect_if_logged_in

    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/"
    else
      redirect "/users/login"
    end
  end

  get "/users/logout" do
    if logged_in?
      session.destroy
    end
      redirect to '/'
  end

  # GET: /users ----------------------
  get "/users" do
    erb :"/users/index.html"
  end

  # GET: /users/new ----------------------
  get "/users/new" do
    erb :"/users/new.html"
  end

  # POST: /users ----------------------
  post "/users" do
    redirect "/users"
  end

  get "/users/:slug" do
    redirect_if_not_logged_in
    @developer = User.find_by_slug(params[:slug])
    erb :"/users/show.html"
  end

  # GET: /users/5/edit ----------------------
  get "/users/:id/edit" do
    erb :"/users/edit.html"
  end

  # PATCH: /users/5 ----------------------
  patch "/users/:id" do
    redirect "/users/:id"
  end

  # DELETE: /users/5/delete ----------------------
  delete "/users/:id/delete" do
    redirect "/users"
  end

  private
  def redirect_if_logged_in
    if logged_in?
      redirect "/"
    end
  end
  
  def current_developer?
    current_user == @developer
  end
end
