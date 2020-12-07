class Development < ActiveRecord::Base
    belongs_to :developer, class_name: "User"

    def summary
        content[0,50] + "..."
    end
end
