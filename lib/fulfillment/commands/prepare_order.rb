module Fulfillment
  module Commands
    class PrepareOrder < Command
      aggregate Fulfillment::OrderFulfillment
      stream_prefix 'OrderFulfillment'
      ident_attr :order_id

      attribute :order_id, Types::Integer
      attribute :barcodes, Types::Array.of(Types::String)
    end
  end
end
