class FollowerDeveloper < ActiveRecord::Base
    belongs_to :follower, class_name: :User
    belongs_to :developer, class_name: :User
end