Spree::Variant.class_eval do
  def count_sold
    -stock_movements.where(originator_type: 'Spree::Shipment').sum(:quantity)
  end

  def count_money
    line_items.joins(:order).where(spree_orders: {state: 'complete'}).pluck(:quantity, :price).map{|l| l[0]*l[1]}.inject(:+)
  end
end
