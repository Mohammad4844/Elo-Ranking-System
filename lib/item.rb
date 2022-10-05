class Item
  attr_accessor :name, :rating, :comparisons_done

  def initialize(name, rating = 1000)
    @name = name
    @rating = rating
  end

  def ==(other)
    @name == other.name && @rating == other.rating
  end

  def to_s
    "#{@name} #{rating}"
  end
end