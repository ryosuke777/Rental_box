Rails.application.routes.draw do

  devise_for :admins, controllers: {
        sessions: 'admins/sessions'
      }

  devise_for :groups, controllers: {
        sessions: 'groups/sessions'
      }

    namespace :admin do
	    get 'homes/top'
	    get 'admin/sign_in' => 'sessions#new'
	    post 'admin/sign_in' => 'sessions#create'
	    delete 'admin/sign_out' => 'sessions#destroy'
	    resources :items
	    resources :genres, only: [:index, :create, :edit, :update]
	    resources :groups, only: [:index, :show, :edit, :update]
	    resources :requests, only: [:index, :show]
	    resources :gases, only: [:index, :create, :edit, :destroy]
    end

    namespace :public do
	    get '/' => 'homes#top'
	    get '/about' => 'homes#about'

	    get 'items/search/:id' => 'items#search'
	    resources :items, only: [:index, :show]

	    get 'groups/sign_up' => 'registrations#new'
	    post 'groups' => 'registrations#create'

	    get 'groups/sign_in' => 'sessions#new'
	    post 'groups/sign_in' => 'sessions#create'
	    delete 'groups/sign_out' => 'sessions#destroy'

	    get 'groups/unsubscribe' => 'groups#unsubscribe'
	    patch 'groups/withdraw' => 'groups#withdraw'
	    resources :groups, only: [:show, :edit, :update]

	    resources :cart_items, only: [:index, :update, :destroy, :create]
	    delete 'cart_items1/delete_all' => 'cart_items#delete_all'

	    get 'requests/thanks' => 'requests#thanks'
	    get 'requests/confirm' => 'requests#confirm'
	    post 'requests/confirm' => 'requests#confirm'
	    resources :requests, only: [:new, :create, :index, :show, :edit, :update]

	    resources :gases, only: [:new, :create, :index, :show]

        patch "gas_requests" => "gas_requests#create"
	    resources :gas_requests, only: [:index, :update, :destroy, :create, :show, :edit]

	    resources :bring_in_equipments, only: [:new, :create, :index, :update, :edit, :destroy]
    end

end
