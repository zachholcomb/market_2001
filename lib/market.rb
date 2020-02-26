class Market
  attr_reader :name, :vendors

  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    @vendors.map do |vendor|
      vendor.name
    end
  end

  def vendors_that_sell(item)
    @vendors.find_all do |vendor|
      vendor.inventory.keys.include?(item)
    end
  end

  def all_items_list
    @vendors.flat_map do |vendor|
      vendor.inventory.keys
    end.uniq
  end

  def item_total(item)
    @vendors.sum do |vendor|
      vendor.check_stock(item)
    end
  end

  def total_inventory
    all_items_list.reduce({}) do |acc, item|
      acc[item] = {
        quantity: item_total(item),
        vendors: vendors_that_sell(item)
            }
      acc
    end
  end

  def overstocked_items
    all_items_list.find_all do |item|
      item_total(item) > 50 && vendors_that_sell(item).length >= 2
    end
  end
end
