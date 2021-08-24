class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :message
  validates :content, presence: true
end
