Rails.application.routes.draw do
  devise_for :users, :controllers => {
    # deviseのコントローラーを上書きしたので追加
    :registrations => "users/registrations",
    :omniauth_callbacks => "users/omniauth_callbacks"
  }
  scope "(:locale)", locale: /en|ja/ do
    resources :books
  end
  root "books#index"
end
