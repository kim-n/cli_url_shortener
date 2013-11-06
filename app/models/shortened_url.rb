class ShortenedUrl < ActiveRecord::Base

  validates :short_url, :long_url, :user_id, :presence => true
  validates :short_url, :uniqueness => true

  belongs_to(
    :submitter,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id
  )
