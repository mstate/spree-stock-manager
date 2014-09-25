Spree::Variant.class_eval do

  def count_sold(from=nil, to=nil)
    query = stock_movements.where(originator_type: 'Spree::Shipment')
    query = query.where('spree_stock_movements.created_at >= ?', Date.parse(from)) if from.present?
    query = query.where('spree_stock_movements.created_at <= ?', Date.parse(to)) if to.present?
    -query.sum(:quantity)
  end

  def count_money(from=nil, to=nil)
    query = line_items.joins(:order).where(spree_orders: {state: 'complete'})
    query = query.where('spree_orders.completed_at >= ?', Date.parse(from)) if from.present?
    query = query.where('spree_orders.completed_at <= ?', Date.parse(to)) if to.present?
    query.pluck(:quantity, :price).map { |l| l[0]*l[1] }.inject(:+)
  end

end
