class Event < ActiveRecord::Base
  belongs_to :doll
  has_many :monsters
  has_many :items

  def test_setup
    @user = User.create
    self.name = 'encount'
    self.doll = @user.dolls.create(:user => @user, :str => 7)
    Array.new(5) {|i| doll.dolls.create :str => 6 - i }
    Array.new(3) {|i| monsters.create :name => :slime }
  end

  def test_run
    test_setup
    encount = self
    treasure = encount.open

    assert treasure.items.count == 3
    assert @user.items.count == 0

    treasure.open

    assert treasure.items.count == 0
    assert @user.items.count == 3

    p encount.doll.members.map(&:hp)
  end

  def assert(flag, message = "error")
    flag or raise message
  end

  def open
    __send__ "open_#{name}"
  end

  # memo: 全員のstr値の合計が相手str値以上なら勝利確定
  # memo: 勝つのは当たり前で大切なのはダメージの有無
  def open_encount
    __log__ :encount, monsters.map(&:name)
    monsters.each {|e| attack(e, target_doll) }
    __log__ :encount_result, win? ? :won : :escape
    if win?
      t = create_new_treasure
      __log__ :treasure_created, t.id
      return t
    end
  end

  private

  def create_new_treasure
    doll.events.create :name => :treasure
  end

  after_create :create_items

  def create_items
    if name == :treasure
      3.times { items.create :name => :hello }
    end
  end

  def win?
    doll.strength > strength(monsters)
  end

  def strength(objs)
    objs.inject(0) {|t, e| t = t + e.str }
  end

  def attack(monster, target)
    monster.attack_times.times do
      target.hp -= 1 if rand(monster.str + 1) >= rand(target.str + 1)
    end
  end

  def target_doll
    return doll if doll.members.size == 1
    while true
      doll.members.each {|e| return e if rand(2) == 0 }
    end
  end
 
  public

  def open_treasure
    items.each do |item|
      item.user = doll.user
      item.event = nil
      item.save
    end
    __log__ :open, name, items.map(&:name)
  end

  private

  def __log__(*args)
    doll.add_message *args
  end
end
