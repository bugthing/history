module Orders
  module Commands
    class AddItem < Command

      aggregate Orders::Order
      stream_prefix 'Order'
      ident_attr :order_id

      attribute :order_id, Types::Integer
      attribute :barcode, Types::String
      attribute :pence, Types::Integer
    end
  end
end
