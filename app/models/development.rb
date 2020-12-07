class Development < ActiveRecord::Base
    validates :title, presence: true
    validates :content, presence: true

    belongs_to :developer, class_name: "User"

    def summary
        content.size > 49 ? content[0,50] +  "..." : content
    end

    def slug
        title.downcase.gsub(" ","-") + id.to_s
    end

    def self.find_by_slug(slug)
        all.find{|a| a.slug == slug}
    end
end
