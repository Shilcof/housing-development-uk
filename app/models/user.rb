class User < ActiveRecord::Base
    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :email, presence: true, uniqueness: true

    validates :company, presence: true, uniqueness: true, if: :developer?
    validates :website, presence: true, uniqueness: true, if: :developer?

    validates_each :first_name, :last_name, :email, :password, :company, :website do |record, attr, value|
        record.errors.add(attr, "must not contain \< or \>") if value && value.match(/[<>]/)
    end

    def developer?
        !!developer
    end

    validates_associated :developments

    has_secure_password

    has_many :developments, foreign_key: :developer_id, dependent: :destroy
    has_many :comments, dependent: :destroy

    # Aliasing to allow a user to follow many developers, and a developer to have many followers ----------------------------
    has_many :follower_associations, class_name: :FollowerDeveloper, foreign_key: :developer_id, dependent: :destroy
    has_many :following_associations, class_name: :FollowerDeveloper, foreign_key: :follower_id, dependent: :destroy

    has_many :followers, through: :follower_associations
    has_many :followed_developers, through: :following_associations, source: :developer
    # -----------------------------------------------------------------------------------------------------------------------

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
