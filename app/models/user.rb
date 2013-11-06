class User < ActiveRecord::Base
  attr_accessible :email

  validates :email, :presence => true, :uniqueness => true, :email => true

  has_many(
    :submitted_urls,
    class_name: "ShortenedUrl",
    foreign_key: :user_id,
    primary_key: :id
  )
end
