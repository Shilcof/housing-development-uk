class Comment < ActiveRecord::Base
    belongs_to :user
    belongs_to :development

    validates :user_id, presence: true
    validates :development_id, presence: true
    validates :body, presence: true
end
