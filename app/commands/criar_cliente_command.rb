class CriarClienteCommand
  include ActiveModel::Model

  attr_accessor :nome, :email, :telefone
  
  validates :nome, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :telefone, presence: true
end