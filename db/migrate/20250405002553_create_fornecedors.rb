class CreateFornecedors < ActiveRecord::Migration[8.0]
  def change
    create_table :fornecedores do |t|
      t.string :nome
      t.string :cnpj
      t.string :telefone

      t.timestamps
    end
  end
end
