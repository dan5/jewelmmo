class Doll < ActiveRecord::Base
  belongs_to :user
  belongs_to :doll
  has_many :dolls
  has_many :events

  def add_message(*args)
    p args
  end

  def inspect
    indent = doll ? ' |- ' : ''
    s = "<id:#{id}(#{events.size}) hp:#{hp}/#{maxhp}>"
    "\t" + indent + s + "\n"
  end

  def members
    [self] + dolls.map(&:members).flatten
  end

  def strength
    raise("doll:#{doll.id} is not master doll!") if doll
    _strength
  end

  def _strength
    str + dolls.inject(0) {|t, e| t = t + e._strength }
  end

  def open
    e = events.first
    e.open
    e.destroy
  end

  def run(n = 1)
    n.times { experiences }
    save!
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
