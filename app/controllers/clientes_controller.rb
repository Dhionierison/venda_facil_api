class ClientesController < ApplicationController
  def create
    command = CriarClienteCommand.new(cliente_params)

    if command.valid?
      cliente = CriarClienteHandler.new.execute(command)
      render json: cliente, status: :created
    else
      render json: { errors: command.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def index
    clientes = ListarClientesQuery.execute
    render json: clientes
  end

  private

  def cliente_params
    params.require(:cliente).permit(:nome, :email, :telefone)
  end
end
