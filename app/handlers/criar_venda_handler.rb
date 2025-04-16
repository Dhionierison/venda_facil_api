class CriarVendaHandler
  def self.execute(command)
    ActiveRecord::Base.transaction do
      cliente = Cliente.find(command.cliente_id)
      venda = Venda.create!(cliente: cliente)

      command.itens.each do |item|
        produto = Produto.find(item[:produto_id])
        venda.venda_itens.create!(
          produto: produto,
          quantidade: item[:quantidade],
          preco_unitario: produto.preco
        )
      end

      venda
    end
  rescue ActiveRecord::RecordNotFound => e
    Rails.logger.error "Registro não encontrado: #{e.message}"
    nil
  rescue ActiveRecord::RecordInvalid => e
    Rails.logger.error "Erro de validação: #{e.message}"
    nil
  end
end