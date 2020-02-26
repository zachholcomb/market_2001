require 'date'
class Market
  attr_reader :name, :vendors, :market_date

  def initialize(name)
    @name = name
    @vendors = []
    @market_date = Date.today
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

  def sorted_item_list
    items_sort = all_items_list.sort_by do |item|
      item.name
    end
    items_sort.map do |item|
      item.name
    end
  end

  def date
    if @market_date.month < 10
      "#{@market_date.day}/0#{@market_date.month}/#{@market_date.year}"
    elsif @market_date > 10
    "#{@market_date.day}/#{@market_date.month}/#{@market_date.year}"
    end
  end

  def sell(item, amount)
    
    return false if total_inventory[item].nil? || total_inventory[item][:quantity] < 0
  end

end
