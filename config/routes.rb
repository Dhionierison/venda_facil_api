Rails.application.routes.draw do
  resources :fornecedores, only: [:create]
  resources :clientes, only: [:index, :create]
  
  resources :vendas, only: [:index, :create] do
    get 'itens', on: :member # Adiciona a rota GET /vendas/:id/itens
    get 'itens_todos', on: :collection
  end
  
  resources :produtos do
    member do
      patch :alterar_preco
    end
  end

  # Rotas de relatórios
  scope :relatorios do
    get "vendas_pdf", to: "relatorios#vendas_pdf"
    get "vendas_por_periodo", to: "relatorios#por_periodo"
    get "vendas_json", to: "relatorios#vendas_json"
  end
end