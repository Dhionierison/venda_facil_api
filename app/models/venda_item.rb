    class VendaItem < ApplicationRecord
      self.table_name = "venda_itens" 
    # Associações
    belongs_to :venda, optional: false  # Impede venda nula
    belongs_to :produto, optional: false  # Impede produto nulo

    # Validações
    validates :quantidade,
              numericality: {
                greater_than: 0,
                only_integer: true  # Se a quantidade deve ser inteira
              }

    validates :preco_unitario,
              numericality: {
                greater_than_or_equal_to: 0,
                message: "não pode ser negativo"
              }

    validates :produto_id, uniqueness: {
      scope: :venda_id,
      message: "já existe um item com este produto na venda"
    } unless :allow_repeated_products?  # Opcional: se permitir produtos repetidos

    # Callbacks
    before_validation :set_preco_unitario, if: :produto_present?
    before_save :calcular_valor_total

    # Métodos
    def calcular_valor_total
      self.valor_total = quantidade * preco_unitario
    end

    def produto_present?
      produto.present?
    end

    def valor_total_item
      quantidade * preco_unitario
    end

    private

    def set_preco_unitario
      self.preco_unitario ||= produto.preco_atual  # Assume que Produto tem preco_atual
    end

    def allow_repeated_products?
      false  # Altere para true se quiser permitir o mesmo produto múltiplas vezes
    end
    end
