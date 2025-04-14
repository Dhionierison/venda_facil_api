class CriarClienteHandler
  def execute(command)
    Cliente.create!(
      nome: command.nome,
      email: command.email,
      telefone: command.telefone
    )
  end
end