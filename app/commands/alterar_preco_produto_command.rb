class AlterarPrecoProdutoCommand
  include ActiveModel::Model
  attr_accessor :id, :novo_preco

  validates :id, presence: true
  validates :novo_preco, presence: true, numericality: { greater_than: 0 }

  def initialize(params = {})
    super(params)
  end
end