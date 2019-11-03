Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	namespace :api, defaults: {format: 'json'} do
	  namespace :v1 do
	  	resources :users do
	    	post '/:user_id/factors/:factor_id/verify', to: 'users#verify_user_factor'
	    	post  '/lifecycle/deactivate', to: 'users#deactivate'
	    end
	    resource :authn do
	    	post '/factors/:factor_id/verify', to: 'authn#factors'
	    end
	  end
	end
end
