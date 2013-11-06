class Visit < ActiveRecord::Base
  attr_accessible :shortened_url_id, :user_id

  belongs_to(
    :visitor,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id
  )

  belongs_to(
    :visited_url,
    class_name: "ShortenedUrl",
    foreign_key: :shortened_url_id,
    primary_key: :id
  )

  def self.record_visit!(user, shortened_url)
    Visit.create!(
      shortened_url_id: shortened_url.id
      user_id: user.id
    )
  end
end
