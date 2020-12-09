require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions
    set :session_secret, ENV['SESSION_SECRET']
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get "/" do
    if logged_in?
      redirect "/developments"
    end
    @developments = Development.all
    erb :welcome
  end

  not_found do
    status 404
    erb :error
  end

  error ActiveRecord::RecordNotFound do
    status 404
    erb :error
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      @current_user ||= User.find(session[:user_id]) if logged_in?
    end
  
    def current_developer?
      current_user == @developer
    end
  end

  private
  def redirect_if_not_logged_in
    if !logged_in?
      redirect "/"
    end
  end
end
