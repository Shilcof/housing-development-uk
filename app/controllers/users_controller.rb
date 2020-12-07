class UsersController < ApplicationController

  # Sign up - log out
  get "/users/signup" do
    redirect_if_logged_in
    erb :"users/new.html"
  end

  post "/users/signup" do
    redirect_if_logged_in

    if !!User.find_by_email(params[:email]) || !!User.find_by_username(params[:username])
      redirect "/signup"
    end
    
    user = User.new(params)
    if user.save
      session[:user_id] = user.id
      redirect "/tweets"
    else
      redirect "/signup"
    end
  end

  get "/users/logout" do
    if logged_in?
      session.destroy
    end
      redirect to '/'
  end

  # GET: /users
  get "/users" do
    erb :"/users/index.html"
  end

  # GET: /users/new
  get "/users/new" do
    erb :"/users/new.html"
  end

  # POST: /users
  post "/users" do
    redirect "/users"
  end

  # GET: /users/5
  get "/users/:id" do
    erb :"/users/show.html"
  end

  # GET: /users/5/edit
  get "/users/:id/edit" do
    erb :"/users/edit.html"
  end

  # PATCH: /users/5
  patch "/users/:id" do
    redirect "/users/:id"
  end

  # DELETE: /users/5/delete
  delete "/users/:id/delete" do
    redirect "/users"
  end

  private
  def redirect_if_logged_in
    if logged_in?
      redirect "/"
    end
  end
end
