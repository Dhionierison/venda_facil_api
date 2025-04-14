class CriarVendaCommand
  include ActiveModel::Model
  attr_accessor :cliente_id, :itens

  validates :cliente_id, presence: true
  validates :itens, presence: true
end