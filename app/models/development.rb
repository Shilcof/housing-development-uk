class Development < ActiveRecord::Base
    def summary
        content[0,50] + "..."
    end
end
