Rails.application.routes.draw do
  resources :fornecedores, only: [:create]
  resources :clientes, only: [:index, :create]
  resources :vendas, only: [:index, :create]
  
  resources :produtos do
    member do
      patch :alterar_preco
    end
  end

  # Rotas de relatórios sem namespace
  get 'relatorios/vendas_pdf', to: 'relatorios#vendas_pdf'
  get 'relatorios/vendas_por_periodo', to: 'relatorios#por_periodo'
  get 'relatorios/vendas_json', to: 'relatorios#vendas_json'
end