
class FollowerDevelopersController < ApplicationController

  before "/follower_developers*" do
    redirect_if_not_logged_in
  end

  get "/follower_developers/follow/:id" do
    @developer = User.find_by_id(params[:id])
    if !@developer || current_user.developer? || @developer.followers.include?(current_user)
      redirect "/"
    end
    FollowerDeveloper.create(follower_id: current_user.id, developer_id: @developer.id)
    redirect "/developers/#{@developer.slug}"
  end

  get "/follower_developers/unfollow/:id" do
    @developer = User.find_by_id(params[:id])
    if !@developer || current_user.developer? || !@developer.followers.include?(current_user)
      redirect "/"
    end
    FollowerDeveloper.find_by(follower_id: current_user.id, developer_id: @developer.id).destroy
    redirect "/developers/#{@developer.slug}"
  end
end
