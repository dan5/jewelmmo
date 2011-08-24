class Monster < ActiveRecord::Base
  belongs_to :event
  before_create :init_params

  attr_reader :str, :attack_times

  def init_params
    values = {
      :slime => [7, 1],
    }[name.to_sym]
    args = %w(@str @attack_times self.hp)
    args.each {|e| eval("#{e} = values.shift") }
  end
end
