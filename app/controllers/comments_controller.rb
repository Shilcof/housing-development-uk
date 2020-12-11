class CommentsController < ApplicationController

  before "/comments*" do
    redirect_if_not_logged_in
  end

  post "/comments" do
    redirect_if_developer_or_no_route
    comment = current_user.comments.build(params[:comment])
    if !comment.save
      flash[:message] = comment.errors.full_messages.join(". ") + "."
    end
    redirect "#{params[:route]}"
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
  def redirect_if_developer_or_no_route
    if !params[:route] || current_user.developer
      redirect "/"
    end
  end
end
