require 'prawn'
require 'prawn/table'

class RelatorioVendasPdfService
  def initialize(vendas)
    @vendas = vendas
  end

  def generate
    Prawn::Document.new(page_size: 'A4', page_layout: :landscape) do |pdf|
      pdf.text "Relatório de Vendas", size: 20, style: :bold, align: :center
      pdf.move_down 10
      pdf.text "Emitido em: #{Time.current.strftime('%d/%m/%Y %H:%M')}", size: 10, align: :right
      pdf.move_down 20

      @vendas.each do |venda|
        pdf.text "Venda ##{venda.id} - Cliente: #{venda.cliente.nome}", style: :bold
        pdf.text "Data da Venda: #{venda.created_at.strftime('%d/%m/%Y %H:%M')}"
        pdf.move_down 5

        data = [["Produto", "Descrição", "Preço Unitário", "Qtd", "Total"]]

        venda.venda_itens.each do |item|
          data << [
            item.produto.nome,
            item.produto.descricao || "-",
            format_currency(item.preco_unitario),
            item.quantidade,
            format_currency(item.quantidade * item.preco_unitario)
          ]
        end

        pdf.table(data, header: true, width: pdf.bounds.width) do
          row(0).background_color = 'CCCCCC'
          row(0).font_style = :bold
          columns(2..4).align = :right
          self.cell_style = { size: 9 }
        end

        pdf.move_down 10
        pdf.text "Total da Venda: #{format_currency(venda.total)}", size: 11, style: :bold, align: :right
        pdf.move_down 20
        pdf.stroke_horizontal_rule
        pdf.move_down 20
      end

      pdf.number_pages "Página <page> de <total>", at: [pdf.bounds.right - 150, 0], size: 9
    end
  end

  private

  def format_currency(value)
    "R$ #{'%.2f' % value}".gsub('.', ',')
  end
end
