class FollowerDeveloper < ActiveRecord::Base
    belongs_to :follower, class_name: :user
    belongs_to :developer, class_name: :user
end