Rails.application.routes.draw do
  resources :fornecedores, only: [:create]
  resources :clientes, only: [:index]
  resources :clientes, only: [:create]
  resources :vendas, only: [:index, :create]
  resources :produtos do
    member do
      patch :alterar_preco
    end
  end
end
