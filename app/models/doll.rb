class Doll < ActiveRecord::Base
  belongs_to :user
  belongs_to :doll
  has_many :dolls

  def attack
    str + dolls.inject(0) {|t, e| t = t + e.str }
  end

  def run(n = 1)
    n.times { experiences }
    exp
  end

  private

  def experiences
    self.exp += 1
    levelup
  end

  def levelup
    exp >= 10 or return
    self.exp = 0
    self.lv += 1
  end
end
