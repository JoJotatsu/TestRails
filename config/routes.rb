Rails.application.routes.draw do
  resources :members
  get 'hello/find'
  get 'hello/find_by'

  namespace :admin do
    resources :books
  end

  resources :books do
    resources :reviews, shallow: true
  end

  resources :fan_comments
  resources :reviews
  resources :authors
  resources :users
  resources :books, constraints: { id: /[0-9]{1,2}/ }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  match ':controller(/:action(/:id))', via: [ :get, :post, :patch]
end
