class User < ActiveRecord::Base
  has_many :dolls
  has_many :items
  belongs_to :town
end
