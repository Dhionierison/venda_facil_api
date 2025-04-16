class VendaIten < ApplicationRecord
  belongs_to :venda
  belongs_to :produto
  
  validates :quantidade, numericality: { greater_than: 0 }
  validates :preco_unitario, numericality: { greater_than_or_equal_to: 0 }
end