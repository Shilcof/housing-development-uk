class User < ActiveRecord::Base
    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :email, presence: true, uniqueness: true

    validates :company, uniqueness: true, allow_blank: true

    validates_associated :developments
    has_secure_password

    has_many :developments, foreign_key: "developer_id"

    def full_name
        [first_name, last_name].join(" ")
    end

    def slug
        company ? company.downcase.gsub(" ","-") : ""
    end

    def self.find_by_slug(slug)
        all.find{|a| a.slug == slug}
    end
end
