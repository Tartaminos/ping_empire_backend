class User < ApplicationRecord
    has_secure_password

    has_many :endpoints
    has_many :jobs

    validates :username, presence: true, uniqueness: true
    validates :email, presence: true, uniqueness: true
end
