class ShortenedUrl < ActiveRecord::Base
  # attr_accessible :title, :body

  validates :shorturl, :longurl, :user_id, :presence => true
  validates :shorturl, :uniqueness => true
end