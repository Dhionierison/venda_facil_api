class CriarProdutoCommand
  include ActiveModel::Model

  attr_accessor :nome, :preco, :descricao, :fornecedor_id

  validates :nome, :descricao, :preco, presence: true
  validates :fornecedor_id, presence: true
  validates :preco, presence: true, numericality: { greater_than: 0 }


  def initialize(params)
    @nome = params[:nome]
    @preco = params[:preco]
    @descricao = params[:descricao]
    @fornecedor_id = params[:fornecedor_id]
  end

  def execute
    return nil unless valid?
    produto = Produto.new(nome: nome, preco: preco, descricao: descricao)
    produto.save ? produto : nil
  end
end
