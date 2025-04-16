class Venda < ApplicationRecord
  belongs_to :cliente
  has_many :venda_itens, class_name: 'VendaIten', dependent: :destroy
  has_many :produtos, through: :venda_itens
end