class AlterarPrecoProdutoHandler
  def self.call(command)
    return nil unless command.valid?
    
    produto = Produto.find_by(id: command.id)
    return nil unless produto

    produto.preco = command.novo_preco
    

    produto.save ? produto : nil
  end
end