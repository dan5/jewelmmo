class Town < ActiveRecord::Base
  has_many :users
  has_many :dungeons
  #has_many :shops
  #has_many :feilds

  after_create :init

  private

  def init
    create_dungeons
  end

  def create_dungeons
    while 1
      dungeons.create
      break unless rand < 0.3
    end
  end
end
