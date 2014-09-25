Spree::Core::Engine.routes.draw do
  namespace :admin do
    resources :reports do
      collection do
        get :stock_overview
        get :sales_total
      end
    end
  end
end
