class CriarFornecedorCommand
  include ActiveModel::Model
  attr_accessor :nome, :cnpj, :telefone

  validates :nome, :cnpj, :telefone, presence: true

  def initialize(params)
    @nome = params[:nome]
    @cnpj = params[:cnpj]
    @telefone = params[:telefone]
  end
end
