require 'valid_email'
class Subscriber < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :email

  validates :email, :presence => true, :email => true, :uniqueness => true
end
