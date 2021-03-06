class Development < ActiveRecord::Base
    validates :title, presence: true
    validates :content, presence: true

    validates_each :title, :content do |record, attr, value|
        record.errors.add(attr, "must not contain \< or \>") if value && value.match(/[<>]/)
    end

    belongs_to :developer, class_name: "User"
    has_many :comments, dependent: :destroy

    @@hashids = Hashids.new(ENV['SALT'], 8)

    def summary
        content.size > 149 ? content[0,150] +  "..." : content
    end

    def html
        content.gsub("\r\n\r\n","<br><br>")
    end

    def slug
        title.downcase.gsub(" ","-") + "-" + @@hashids.encode(id)
    end

    def self.find_by_slug(slug)
        all.find{|a| a.slug == slug}
    end
    
    def average_rating
        @comments ||= comments
        if @comments.select{|comment| comment.rating != ""}.size == 0
            "Currently unrated"
        else
            (@comments.reduce(0){|sum,comment| comment.rating == "" ? sum : sum + comment.rating}/(@comments.select{|comment| comment.rating != ""}.size).to_f).round(2)
        end
    end
end
