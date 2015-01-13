class Link < ActiveRecord::Base
  acts_as_votable
  belongs_to :user
  has_many :comments

  self.per_page = 10
end
