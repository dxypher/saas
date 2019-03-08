class Standup < ApplicationRecord
  include Friendlyable
  belongs_to :user

  validates :user, presence: true
end
