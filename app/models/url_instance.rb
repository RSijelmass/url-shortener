class UrlInstance < ApplicationRecord
  belongs_to :user, optional: true

  validates :longhand, presence: true
  validates :user_id, presence: true
end
