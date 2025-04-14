class CreateProdutos < ActiveRecord::Migration[8.0]
  def change
    create_table :produtos do |t|
      t.string :name
      t.text :descricao
      t.decimal :preco

      t.timestamps
    end
  end
end
