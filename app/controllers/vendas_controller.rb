class VendasController < ApplicationController
  def index
    vendas = ListarVendasQuery.execute
    render json: vendas
  end

  def create
    command = CriarVendaCommand.new(venda_params)

    if command.valid?
      venda = CriarVendaHandler.execute(command)
      render json: venda, status: :created
    else
      render json: { errors: command.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def venda_params
    params.require(:venda).permit(:cliente_id, itens: [:produto_id, :quantidade])
  end
end
