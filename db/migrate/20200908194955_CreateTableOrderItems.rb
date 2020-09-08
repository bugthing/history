# frozen_string_literal: true

ROM::SQL.migration do
  change do
    create_table :order_items do |t|
      column :id, Integer, null: false
      primary_key [:id]
      column :order_id, String, null: false
      column :barcode, String, null: false
      column :pence, Integer, null: false
      column :state, String, null: false
    end
  end
end
