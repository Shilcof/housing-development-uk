
class UsersController < ApplicationController

  get "/users/signup" do
    redirect_if_logged_in
    erb :"users/new.html"
  end

  post "/users/signup" do
    redirect_if_logged_in
    user = User.new(params)
    if user.save
      session[:user_id] = user.id
      if user.developer
        redirect "/developers/#{user.slug}"
      else
        redirect "/users/home"
      end
    else
      flash[:message] = user.errors.full_messages.join(". ").gsub("Company can't be blank. Company has already been taken.", "Company can't be blank.").gsub("Website can't be blank. Website has already been taken.", "Website can't be blank.") + "."
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
      if user.developer
        redirect "/developers/#{user.slug}"
      else
        redirect "/users/home"
      end
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

  get "/users/home" do
    redirect_if_not_logged_in
    @user = current_user
    if current_user.developer
      redirect "/developers/#{current_user.slug}"
    end
    @comments = @user.comments.includes(:user, :development)
    @followed_developers = @user.followed_developers
    erb :"/users/show.html"
  end

  private
  def redirect_if_logged_in
    if logged_in?
      redirect "/developments"
    end
  end
end
