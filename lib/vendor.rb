class Vendor
  attr_reader :name, :inventory

  def initialize(name)
    @name = name
    @inventory = Hash.new(0)
  end

  def check_stock(item_param)
    @inventory[item_param]
  end

  def stock(item, amount)
    if check_stock(item) == 0
      @inventory[item] = amount
    else
      @inventory[item] += amount
    end
  end
end
