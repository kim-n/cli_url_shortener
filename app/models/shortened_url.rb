class ShortenedUrl < ActiveRecord::Base
  attr_accessible :short_url, :long_url, :user_id

  validates :short_url, :long_url, :user_id, :presence => true
  validates :short_url, :uniqueness => true

  belongs_to(
    :submitter,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id
  )

  has_many(
    :visits,
    class_name: "Visit",
    foreign_key: :shortened_url_id,
    primary_key: :id
  )

  has_many(
    :visitors,
    through: :visits,
    source: :visitor,
    uniq: true
  )

  def num_clicks
    self.visits.count
  end

  def num_uniques
    self.visitors.count
  end

  def num_recent_uniques
    self.visitors.where("visits.created_at > ?", 10.minutes.ago).count
  end

  def self.random_code
    random_code = SecureRandom::urlsafe_base64

    until ShortenedUrl.find_by_short_url(random_code).nil?
      random_code = SecureRandom::urlsafe_base64
    end

    random_code
  end

  def self.create_for_user_and_long_url!(user, long_url)
    ShortenedUrl.create!(
    short_url: ShortenedUrl.random_code,
    long_url: long_url,
    user_id: user.id
  )
  end


end
