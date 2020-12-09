class CommentsController < ApplicationController

  before "/comments*" do
    redirect_if_not_logged_in
  end

  # GET: /comments
  get "/comments" do
    erb :"/comments/index.html"
  end

  # GET: /comments/new
  get "/comments/new" do
    erb :"/comments/new.html"
  end

  post "/comments" do
    redirect_if_developer_or_no_route
    comment = current_user.comments.build(params[:comment])
    if !current_user.save
      flash[:message] = comment.errors.full_messages.join(". ") + "."
    end
    redirect "#{params[:route]}"
  end

  # GET: /comments/5
  get "/comments/:id" do
    erb :"/comments/show.html"
  end

  # GET: /comments/5/edit
  get "/comments/:id/edit" do
    erb :"/comments/edit.html"
  end

  # PATCH: /comments/5
  patch "/comments/:id" do
    redirect "/comments/:id"
  end

  delete "/comments/:id" do
    redirect_if_developer_or_no_route
    @comment = Comment.find_by_id(params[:id])
    if @comment.user == current_user
      @comment.destroy
    end
    redirect "#{params[:route]}"
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

  def redirect_if_developer_or_no_route
    if !params[:route] || current_user.developer
      redirect "/"
    end
  end
end
