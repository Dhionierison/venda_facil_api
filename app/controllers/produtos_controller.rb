class ProdutosController < ApplicationController
  def index
    produtos = ListarProdutosQuery.execute
    render json: produtos
  end
  
  def create
    command = CriarProdutoCommand.new(produto_params)

    if command.valid?
      produto = CriarProdutoHandler.execute(command)
      render json: produto, status: :created
    else
      render json: { errors: command.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def alterar_preco
    command = AlterarPrecoProdutoCommand.new(
      id: params[:id].to_i,
      novo_preco: params[:novo_preco].to_f
    )

    if command.valid?
      produto = AlterarPrecoProdutoHandler.call(command)
      render json: produto, status: :ok
    else
      render json: { errors: command.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def produto_params
    params.require(:produto).permit(:nome, :preco, :descricao, :fornecedor_id)
  end
end
