class Produto < ApplicationRecord
  belongs_to :fornecedor
  has_many :venda_itens
  has_many :vendas, through: :venda_itens
end

class Fornecedor < ApplicationRecord
  has_many :produtos
end

class Venda < ApplicationRecord
  has_many :produtos
  belongs_to :cliente
end