class FornecedoresController < ApplicationController
  def create
    command = CriarFornecedorCommand.new(fornecedor_params)

    if command.valid?
      fornecedor = CriarFornecedorHandler.execute(command)
      render json: fornecedor, status: :created
    else
      render json: { errors: command.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def fornecedor_params
    params.require(:fornecedor).permit(:nome, :cnpj, :telefone)
  end
end
