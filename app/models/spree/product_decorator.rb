Spree::Product.class_eval do

  has_many :stock_movements, through: :stock_items

  unless self.respond_to?(:sold_out?)
    def sold_out?
      total_on_hand <= 0 && stock_items.inject(true) { |sum, stock_item| sum && !stock_item.backorderable }
    end
  end

  unless self.respond_to?(:has_stock?)
    def has_stock?
      !sold_out?
    end
  end

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
