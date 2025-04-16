# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_04_15_233557) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "clientes", force: :cascade do |t|
    t.string "nome"
    t.string "email"
    t.string "telefone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "fornecedores", force: :cascade do |t|
    t.string "nome"
    t.string "cnpj"
    t.string "telefone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "produtos", force: :cascade do |t|
    t.string "nome"
    t.text "descricao"
    t.decimal "preco"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "fornecedor_id"
    t.index ["fornecedor_id"], name: "index_produtos_on_fornecedor_id"
  end

  create_table "venda_itens", force: :cascade do |t|
    t.bigint "venda_id", null: false
    t.bigint "produto_id", null: false
    t.integer "quantidade"
    t.decimal "preco_unitario", precision: 10, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["produto_id"], name: "index_venda_itens_on_produto_id"
    t.index ["venda_id"], name: "index_venda_itens_on_venda_id"
  end

  create_table "vendas", force: :cascade do |t|
    t.bigint "cliente_id", null: false
    t.integer "quantidade"
    t.decimal "valor_total"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cliente_id"], name: "index_vendas_on_cliente_id"
  end

  add_foreign_key "produtos", "fornecedores"
  add_foreign_key "venda_itens", "produtos"
  add_foreign_key "venda_itens", "vendas"
  add_foreign_key "vendas", "clientes"
end
