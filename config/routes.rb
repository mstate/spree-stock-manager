Spree::Core::Engine.routes.draw do
  namespace :admin do 
    resources :products do 
    	collection do
    		get :stock_overview
    	end
    end
  end
end
