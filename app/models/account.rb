class Account < ActiveRecord::Base
  has_one :open_id
  has_many :providers
end
