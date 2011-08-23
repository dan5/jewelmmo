class Event < ActiveRecord::Base
  belongs_to :doll
  has_many :monsters
  has_many :items

  def test_setup
    @dolls = Array.new(5) {|i| Doll.new :str => 13 - i * 3 }
    self.doll = @dolls.first
    self.name = 'encount'
  end

  def open
    __send__ "open_#{name}"
  end

  def open_encount
    win?
    monsters
    monster_str = 8
    attack_times = 3
    while attack_times > 0
      doll = target_doll
      doll.hp -= 1 if rand(monster_str + 1) >= rand(doll.str + 1)
      attack_times -= 1
    end
    @dolls.map(&:hp)
    # memo: 戦闘はstr比較だけでいいかも
    # * 全員のstr値の合計が相手str値以上なら勝利確定
    # * 勝つのは当たり前で大切なのはダメージの有無
  end

  def win?
    doll.attack > monsters.inject(0) {|t, e| t = t + e.str }
  end

  def target_doll
    return if @dolls.empty?
    return @dolls.first if @dolls.size == 1
    while true
      @dolls.each do |doll|
        return doll if rand(2) == 0
      end
    end
  end
 
  def open_treasure
    items.each do |item|
      item.user = doll.user
      doll.add_message :open, name, item.item_def.id
      #=> [open, "treasure", 11]
    end
  end
end
