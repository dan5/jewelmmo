class Doll < ActiveRecord::Base
  belongs_to :user
  belongs_to :doll
  has_many :dolls
  has_many :events
  def leader?() !doll end

  def add_message(*args)
    p args
  end

  def simple_inspect
    indent = doll ? '  ' : ''
    head = indent + "d#{user.dolls.index(self)}. id:#{'%04d' % id}(#{events.size})"
    body =  "lv:#{lv} hp:#{hp}/#{maxhp} exp:#{exp} act:#{action}(#{act_counter})"
    head.ljust(14) + body
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

  def follow(leader)
    leader != self or raise "it's you!"
    dolls.count == 0 or raise "you is a leader!"
    leader.leader? or raise "is'nt a leader!"
    update_attribute :doll, leader
    "follow #{leader}"
  end

  def unfollow
    update_attribute :doll, nil
  end

  def open
    e = events.first
    e.open
    e.destroy
  end

  def start
    leader? or raise
    update_attribute :action, 'explore'
  end

  def stop
    leader? or raise
    _stop
    dolls.each &:_stop 
  end

  def _stop
    update_attribute :action, nil
    update_attribute :hp, 1
  end

  def sleep
    _sleep
    dolls.each &:_sleep
  end

  def _sleep
    update_attribute :action, 'sleep'
  end

  def run(n = 1)
    n.times {
      act
      dolls.each {|e| e.run(n) }
    }
    save!
    exp
  end

  private

  def act
    __send__ "act_#{action or 'nop'}"
  end

  def act_nop
  end

  def act_sleep
    self.hp += 1 if rand(hp) < 1
  end

  def act_explore
    events.create :name => :encount
    experiences
  end

  def experiences
    self.exp += 1
    #levelup
  end

  def levelup
    exp >= 10 or return
    self.exp = 0
    self.lv += 1
  end
end
