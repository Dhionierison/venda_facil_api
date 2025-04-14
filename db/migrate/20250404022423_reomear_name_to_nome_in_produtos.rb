class ReomearNameToNomeInProdutos < ActiveRecord::Migration[8.0]
  def change
    rename_column :produtos, :name, :nome
  end
end
