class User < ApplicationRecord
    has_many :endpoints
    has_many :jobs
    has_secure_password
end
