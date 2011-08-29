class Item < ActiveRecord::Base
  belongs_to :user
  belongs_to :doll
  belongs_to :event


  def item_def
    name
  end
end
