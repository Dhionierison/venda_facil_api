class RelatoriosController < ApplicationController
  def vendas_pdf
    filtros = params.permit(:cliente_id, :produto_id, :data_inicio, :data_fim)
    pdf = RelatorioVendasPdfService.new(filtros).gerar

    send_data pdf,
              filename: "relatorio_vendas.pdf",
              type: "application/pdf",
              disposition: "inline"
  end

  def vendas_json
    vendas = buscar_vendas(params)

    render json: vendas.map { |venda|
      {
        id: venda.id,
        data: venda.created_at.strftime("%Y-%m-%d"),
        cliente: venda.cliente.nome,
        valor_total: venda.total,
        itens: venda.venda_itens.map { |item|
          {
            produto: item.produto.nome,
            descricao: item.produto.descricao,
            quantidade: item.quantidade,
            preco_unitario: item.preco_unitario,
            total: item.quantidade * item.preco_unitario
          }
        }
      }
    }
  end

  private

  def buscar_vendas(params)
    vendas = Venda.includes(:cliente, venda_itens: :produto)
    vendas = vendas.where(cliente_id: params[:cliente_id]) if params[:cliente_id].present?
    vendas = vendas.where(created_at: params[:data_inicio]..params[:data_fim]) if params[:data_inicio].present? && params[:data_fim].present?

    if params[:produto_id].present?
      vendas = vendas.joins(:venda_itens).where(venda_itens: { produto_id: params[:produto_id] }).distinct
    end

    vendas
  end
end
