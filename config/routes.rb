Rails.application.routes.draw do
  resources :loans, defaults: {format: :json} do
     member do
      get 'payments'
    end
  end
  resources :payments, defaults: {format: :json}
end
