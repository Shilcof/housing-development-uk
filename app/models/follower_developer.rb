class FollowerDeveloper < ActiveRecord::Base
    belongs_to :follower, class: :user
    belongs_to :developer, class: :user
end