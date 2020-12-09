class Development < ActiveRecord::Base
    validates :title, presence: true
    validates :content, presence: true

    belongs_to :developer, class_name: "User"
    has_many :comments

    def summary
        content.size > 149 ? content[0,150] +  "..." : content
    end

    def html
        content.gsub("\r\n\r\n","<br><br>")
    end

    def slug
        title.downcase.gsub(" ","-") + id.to_s
    end

    def self.find_by_slug(slug)
        all.find{|a| a.slug == slug}
    end
end
