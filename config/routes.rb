Rails.application.routes.draw do
  devise_for :users
  scope "(:locale)", locale: /en|ja/ do
    resources :books
  end
  root "books#index"
end
