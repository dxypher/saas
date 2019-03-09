class Account < ApplicationRecord
  include Friendlyable
  resourcify #Rolify

  has_many :users
  has_many :teams

  validates :name, presence: :true
end
