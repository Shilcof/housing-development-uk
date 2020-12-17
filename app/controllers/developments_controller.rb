

class DevelopmentsController < ApplicationController

  before "/developments*" do
    redirect_if_not_logged_in
  end

  get "/developments" do
    if @search = params[:search]
      @developments = Development.where("title like ?", "%#{@search}%").includes(:developer)
    else
      @developments = Development.all.includes(:developer)
    end
    erb :"/developments/index.html"
  end

  get "/developments/new" do
    redirect_if_not_developer
    erb :"/developments/new.html"
  end

  post "/developments" do
    redirect_if_not_developer
    development = current_user.developments.build(params)
    if current_user.save
      redirect "/developers/#{current_user.slug}"
    else
      flash[:message] = development.errors.full_messages.join(". ") + "."
      redirect "/developments/new"
    end
  end

  get "/developments/:slug" do
    if @development = Development.find_by_slug(params[:slug])
      @developer = @development.developer
      @comments = @development.comments.includes(:user)
      @current_uri = request.env['PATH_INFO']
      puts "marker"
      erb :"/developments/show.html"
    else
      erb :error
    end
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
      flash[:message] = @development.errors.full_messages.join(". ") + "."
      redirect "/developments/#{params[:slug]}/edit"
    end
  end

  delete "/developments/:slug" do
    redirect_if_not_developer
    @development = Development.find_by_slug(params[:slug])
    @developer = @development.developer
    redirect_if_wrong_developer(@developer)
    @development.destroy
    redirect "/developers/#{ current_user.slug }"
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
