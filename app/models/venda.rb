class Venda < ApplicationRecord
  belongs_to :cliente, optional: false
  has_many :venda_itens, dependent: :destroy
  has_many :produtos, through: :venda_itens
  
  accepts_nested_attributes_for :venda_itens, allow_destroy: true
  
  before_save :calcular_total_venda
  
  private
  
  def calcular_total_venda
    self.total = venda_itens.sum(&:valor_total)
  end
end