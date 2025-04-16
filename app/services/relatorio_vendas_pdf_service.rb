class RelatorioVendasPdfService
  def initialize(filtros = {})
    @filtros = filtros
  end

  def gerar
    vendas = Venda.includes(:cliente, venda_itens: :produto).where(nil)

    vendas = vendas.where(cliente_id: @filtros[:cliente_id]) if @filtros[:cliente_id].present?

    if @filtros[:data_inicio].present? && @filtros[:data_fim].present?
      inicio = Date.parse(@filtros[:data_inicio]) rescue nil
      fim = Date.parse(@filtros[:data_fim]) rescue nil
      vendas = vendas.where(created_at: inicio.beginning_of_day..fim.end_of_day) if inicio && fim
    end

    # Filtro por produto
    if @filtros[:produto_id].present?
      vendas = vendas.joins(:venda_itens).where(venda_itens: { produto_id: @filtros[:produto_id] }).distinct
    end

    gerar_pdf(vendas)
  end

  private

  def gerar_pdf(vendas)
    Prawn::Document.new(page_size: 'A4', page_layout: :landscape) do |pdf|
      pdf.text "Relatório de Vendas", size: 20, style: :bold
      pdf.move_down 20

      vendas.each do |venda|
        pdf.text "ID da Venda: #{venda.id}"
        pdf.text "Cliente: #{venda.cliente.nome}"
        pdf.text "Data da Venda: #{venda.created_at.strftime('%d/%m/%Y')}"
        pdf.move_down 5

        data = [["Produto", "Descrição", "Qtd", "Preço Unitário", "Total"]]

        venda.venda_itens.each do |item|
          produto = item.produto
          data << [
            produto.nome,
            produto.descricao || "-",
            item.quantidade,
            format_currency(item.preco_unitario),
            format_currency(item.preco_unitario * item.quantidade)
          ]
        end

        pdf.table(data, header: true, width: pdf.bounds.width) do
          row(0).background_color = 'CCCCCC'
          row(0).font_style = :bold
          columns(2..4).align = :right
        end

        pdf.move_down 10
        pdf.text "Total da Venda: #{format_currency(venda.total)}", align: :right, style: :bold
        pdf.move_down 20
        pdf.stroke_horizontal_rule
        pdf.move_down 20
      end
    end.render
  end

  def format_currency(valor)
    "R$ #{'%.2f' % valor}".gsub('.', ',')
  end
end
