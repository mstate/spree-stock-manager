Deface::Override.new(:virtual_path => "spree/admin/shared/_product_sub_menu", 
                      :name => "add_link_to_stock_to_admin_products", 
                      :insert_bottom => "ul#sub_nav",
                      :text => "<li><%= link_to t('stock_manager.link'), stock_overview_admin_products_path %></li>")
