class RelatoriosController < ApplicationController
  def vendas_pdf
    filtro_params = {
      data_inicio: params[:data_inicio],
      data_fim: params[:data_fim],
      cliente_id: params[:cliente_id],
      produto_id: params[:produto_id]
    }.compact_blank

    pdf = RelatorioVendasPdfService.new(filtro_params).gerar

    send_data pdf, filename: 'relatorio_vendas.pdf', type: 'application/pdf'
  end
end
