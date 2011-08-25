class Event < ActiveRecord::Base
  belongs_to :doll
  has_many :monsters
  has_many :items

  def open
    __send__ "open_#{name}"
  end

  private

  after_create :setup_after_create

  def setup_after_create
    case name
    when :treasure then create_items
    when :encount then Array.new(3) {|i| monsters.create :name => :slime }
    end
  end

  def open_treasure
    items.each do |item|
      item.user = doll.user
      item.event = nil
      item.save
    end
    __log__ :open, name, items.map(&:name)
  end

  # memo: 全員のstr値の合計が相手str値以上なら勝利確定
  # memo: 勝つのは当たり前で大切なのはダメージの有無
  def open_encount
    __log__ :encount, monsters.map(&:name)
    monsters.each {|mons| attack(mons) }
    __log__ :encount_result, win? ? :won : :escape
    if win?
      t = doll.events.create :name => :treasure
      __log__ :treasure_created, t.id
      return t
    end
  end

  def create_items
    3.times { items.create :name => :hello }
  end

  def win?
    doll.strength > strength(monsters)
  end

  def strength(objs)
    objs.inject(0) {|t, e| t = t + e.str }
  end

  def attack(monster)
    monster.attack_times.times do
      target = target_doll
      if rand(monster.str + 1) >= rand(target.str + 1)
        target.hp -= 1
        target.save
      end
    end
  end

  def target_doll
    return doll if doll.members.size == 1
    while true
      doll.members.each {|e| return e if rand(2) == 0 }
    end
  end
 
  def __log__(*args)
    doll.add_message *args
  end
end
