class ListarVendasQuery
  def self.execute
    Venda.includes(:cliente, venda_itens: :produto).all.as_json(
      include: {
        cliente: {},
        venda_itens: {
          include: :produto
        }
      }
    )
  end
end