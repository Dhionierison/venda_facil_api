class RelatoriosController < ApplicationController
  def vendas_pdf
    vendas = Venda.includes(:cliente, venda_itens: :produto)

    pdf = RelatorioVendasPdfService.new(vendas).generate

    send_data pdf.render,
              filename: "relatorio_vendas_#{Time.current.strftime('%Y%m%d_%H%M%S')}.pdf",
              type: 'application/pdf',
              disposition: 'inline'
  end
end
