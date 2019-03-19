class Task < ApplicationRecord
  validates :title, presence: true
  validates :type, presence: true

  has_many :task_memberships
  has_many :standups, through: :task_memberships
end
