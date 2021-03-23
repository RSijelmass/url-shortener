class UrlInstance < ApplicationRecord
  belongs_to :user, optional: true
end
