class User < ActiveRecord::Base
  # attr_accessible :title, :body

  validates :email, :presence => true, :uniqueness => true, :email => true
end
