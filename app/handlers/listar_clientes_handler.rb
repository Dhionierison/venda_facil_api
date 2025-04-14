class ListarClientesHandler
  def execute(query)
    Cliente.all
  end
end