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

  def count_sold
    -stock_movements.where(originator_type: 'Spree::Shipment').sum(:quantity)
  end

  def count_money
    line_items.joins(:order).where(spree_orders: {state: 'complete'}).pluck(:quantity, :price).map{|l| l[0]*l[1]}.inject(:+)
  end
end
