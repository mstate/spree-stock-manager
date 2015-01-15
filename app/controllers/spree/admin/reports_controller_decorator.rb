Spree::Admin::ReportsController.class_eval do

  def initialize
    super
    Spree::Admin::ReportsController.add_available_report!(:sales_total)
    Spree::Admin::ReportsController.add_available_report!(:stock_overview)
  end

  def stock_overview
    @products = Spree::Product.joins(:master).order('spree_variants.sku')
  end
end
