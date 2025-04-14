  class CriarVendaHandler
    def self.execute(command)
      cliente = Cliente.find_by(id: command.cliente_id)
      return nil unless cliente

      venda = Venda.new(cliente: cliente)

      
      return nil unless venda.save

      
      command.itens.each do |item|
        produto = Produto.find_by(id: item[:produto_id])
        next unless produto

      venda.venda_itens.create!(
      produto: produto,
      quantidade: item[:quantidade],
      preco_unitario: produto.preco,
  )
      end

      venda
    end
  end
