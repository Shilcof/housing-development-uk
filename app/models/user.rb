class User < ActiveRecord::Base
    has_many :developments, foreign_key: "developer_id"
end
