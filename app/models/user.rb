class User < ActiveRecord::Base
  has_many :dolls
  belongs_to :town
end
