module Spree
  Product.class_eval do
  	unless self.respond_to?(:sold_out?)
	  	def sold_out?
	  		total_on_hand <= 0 && stock_items.inject(true){|sum, stock_item| sum && !stock_item.backorderable}
	  	end
	end
	unless self.respond_to?(:has_stock?)
	  	def has_stock?
	  		!sold_out?
	  	end
	end

  end
end