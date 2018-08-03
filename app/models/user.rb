class User < ActiveRecord::Base
  has_secure_password

  has_many :facts

  def slug
    self.username.gsub(" ","-").downcase
  end

  def self.find_by_slug(slug)
    user = slug.gsub("-"," ")
    User.find_by(:username => user)
  end

end
