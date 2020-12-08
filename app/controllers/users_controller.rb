require "rack-flash"

class UsersController < ApplicationController
  use Rack::Flash

  get "/users/signup" do
    redirect_if_logged_in
    erb :"users/new.html"
  end

  post "/users/signup" do
    redirect_if_logged_in

    user = User.new(params)
    if user.save
      session[:user_id] = user.id
      redirect "/developments"
    else
      flash[:message] = user.errors.full_messages.join(". ") + "."
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
      redirect "/developments"
    else
      flash[:message] = "Email or password was incorrect."
      redirect "/users/login"
    end
  end

  get "/users/logout" do
    if logged_in?
      session.destroy
    end
    redirect to '/'
  end

  get "/users/:slug" do
    redirect_if_not_logged_in
    @developer = User.find_by_slug(params[:slug])
    erb :"/users/show.html"
  end

  private
  def redirect_if_logged_in
    if logged_in?
      redirect "/developments"
    end
  end
end
