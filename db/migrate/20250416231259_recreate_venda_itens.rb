class RecreateVendaItens < ActiveRecord::Migration[8.0]
  def change
    create_table :venda_itens do |t|
      t.references :venda, null: false, foreign_key: true
      t.references :produto, null: false, foreign_key: true
      t.integer :quantidade
      t.decimal :preco_unitario, precision: 10, scale: 2

      t.timestamps
    end
  end
end
