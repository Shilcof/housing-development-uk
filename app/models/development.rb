class Development < ActiveRecord::Base
    validates :title, presence: true
    validates :content, presence: true

    belongs_to :developer, class_name: "User"

    def summary
        content[0,50] + "..."
    end
end
