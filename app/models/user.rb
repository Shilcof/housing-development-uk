class User < ActiveRecord::Base
    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :email, presence: true, uniqueness: true
    validates_associated :developments
    has_secure_password

    has_many :developments, foreign_key: "developer_id"

end
