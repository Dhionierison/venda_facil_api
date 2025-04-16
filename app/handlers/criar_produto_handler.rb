class CriarProdutoHandler
  def self.execute(command)
    return nil unless command.valid?

    produto = Produto.new(nome: command.nome, preco: command.preco, descricao: command.descricao, fornecedor_id: command.fornecedor_id)

    if produto.save
      produto
    else
      nil
    end
  end
end
