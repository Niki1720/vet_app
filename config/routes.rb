Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      post "auth/login", to: "authentication#login"
      resources :animals
      resources :users
    end
  end
end
