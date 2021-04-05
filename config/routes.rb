Rails.application.routes.draw do

  devise_for :admins, controllers: {
        sessions: 'admins/sessions'
      }

  devise_for :groups, controllers: {
        sessions: 'groups/sessions'
      }
  root 'public/homes#top'
    namespace :admin do
	    get 'homes/top'
	    get 'admin/sign_in' => 'sessions#new'
	    post 'admin/sign_in' => 'sessions#create'
	    delete 'admin/sign_out' => 'sessions#destroy'

	    get 'items/order_list' => 'items#order_list'
	    resources :items
	    resources :genres, only: [:index, :create, :edit, :update]
	    resources :groups, only: [:index, :show, :edit, :update, :destroy]

	    delete 'requests/destroy_order_gas/:id' => 'requests#destroy_order_gas'
	    patch  'requests/change_order_item_amount/:id' => 'requests#change_order_item_amount'
	    patch  'requests/change_order_gas_amount/:id' => 'requests#change_order_gas_amount'
	    resources :requests, only: [:index, :show, :edit, :update, :destroy]
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

    if Rails.env.development?
      mount LetterOpenerWeb::Engine, at: '/letter_opener'
    end

end
