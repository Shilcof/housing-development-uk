class Development < ActiveRecord::Base
    def summary
        content[0,20] + "..."
    end
end
