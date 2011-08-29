class User < ActiveRecord::Base
  has_many :dolls
  has_many :items
  belongs_to :town

  def run
    dolls.map(&:run)
  end
end
