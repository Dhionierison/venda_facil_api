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

  def itens_todos
    venda_itens = VendaItem.includes(:produto, :venda).all.as_json(
      include: {
        produto: { only: [:id, :nome, :preco] },
        venda: { only: [:id] }
      },
      methods: [] # se quiser métodos extras aqui
    )
    render json: venda_itens
  end



  # Nova ação para listar itens
   def itens
    venda = Venda.includes(venda_itens: :produto).find_by(id: params[:id])
  
    if venda
      render json: {
        venda_id: venda.id,
        itens: venda.venda_itens.as_json(
          include: {
            produto: { only: [:id, :nome, :preco] }
          },
          methods: [:valor_total_item] # Agora o método existe
        )
      }
    else
      render json: { error: "Venda não encontrada" }, status: :not_found
    end
  end

  private

  def venda_params
    params.require(:venda).permit(:cliente_id, itens: [:produto_id, :quantidade])
  end
end