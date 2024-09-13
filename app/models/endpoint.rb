class Endpoint < ApplicationRecord
  belongs_to :user
  
  has_many :jobs
  has_many :endpoint_statuses
end
