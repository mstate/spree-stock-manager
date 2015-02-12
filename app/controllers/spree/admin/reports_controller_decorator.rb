Spree::Admin::ReportsController.class_eval do

  def initialize
    super
    Spree::Admin::ReportsController.add_available_report!(:sales_total)
    Spree::Admin::ReportsController.add_available_report!(:stock_overview)
  end

  def stock_overview
    @variant_sales_by_id = {}
  	@from = params[:from] && Date.parse(params[:from]).kind_of?(Date) ? Date.parse(params[:from]) : Date.civil(1970,1,1)
  	@to = params[:to] && Date.parse(params[:to]).kind_of?(Date) ? Date.parse(params[:to]) : Time.now.to_date
    variant_sales = Spree::Variant.joins(:line_items).
      where("spree_line_items.created_at >= ?", @from).
      where("spree_line_items.created_at <= ?", @to).
      group(:variant_id).
      select("sum(spree_line_items.quantity) as total_quantity_sold, sum(spree_line_items.price * spree_line_items.quantity) as total_sales, spree_line_items.variant_id as variant_id")
    variant_sales.each do |variant_sale|
      @variant_sales_by_id[variant_sale.variant_id] = variant_sale
    end
    @products = Spree::Product.not_deleted.available.uniq.all.sort_by{|product| @variant_sales_by_id[product.master.id].present? ? (product.total_on_hand || 0).to_f / @variant_sales_by_id[product.master.id].total_quantity_sold : 10000.0}

  	# case params
   #  @products = Spree::Product.joins(:master).order('spree_variants.sku')
  end

  private
  
  def product_sort_column
    Product.column_names.include?(params[:sort]) ? params[:sort] : "spree_variants.sku"
  end
  
  def product_sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
