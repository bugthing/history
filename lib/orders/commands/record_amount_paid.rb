module Orders
  module Commands
    class RecordAmountPaid < Command

      aggregate Orders::Order
      stream_prefix 'Order'
      ident_attr :order_id

      attribute :order_id, Types::Integer
      attribute :pence, Types::Integer
    end
  end
end
