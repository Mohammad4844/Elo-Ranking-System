class Item
  attr_accessor :name, :rating

  def initialize(name, rating = 1000)
    @name = name
    @rating = rating
  end
end