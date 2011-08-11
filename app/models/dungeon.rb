class Dungeon < ActiveRecord::Base
  belongs_to :town
  before_create :init_lv

  private

  def init_lv
    rand < 0.7 ? self.lv += 1 : break while true
  end
end
