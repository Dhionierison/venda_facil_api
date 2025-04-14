class CriarFornecedorHandler
  def self.execute(command)
    return nil unless command.valid?

    Fornecedor.create(
      nome: command.nome,
      cnpj: command.cnpj,
      telefone: command.telefone
    )
  end
end
