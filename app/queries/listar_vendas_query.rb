class ListarVendasQuery
  def self.execute
    Venda.includes(:cliente, :produto).all.as_json(include: [:cliente, :produto])
  end
end