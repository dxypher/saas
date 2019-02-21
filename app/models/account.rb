class Account < ApplicationRecord
  resourcify #Rolify
  has_many :users

  validates :name, presence: :true
end
