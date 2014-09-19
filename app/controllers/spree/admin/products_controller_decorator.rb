Spree::Admin::ProductsController.class_eval do

  def stock_overview
    @products = Spree::Product.all
  end
end
