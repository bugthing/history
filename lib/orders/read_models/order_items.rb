module Orders
  module ReadModels
    class OrderItems < ROM::Relation[:sql]
      schema(:order_items, infer: true)

      def by_order_id(order_id)
        order_items.where(order_id: order_id).to_a
      end

      def set_fulfilled(order_id)
        where(order_id: order_id).each do |r|
          by_pk(r[:id]).changeset(:update, state: 'fulfilled').commit
        end
      end

      def create(order_id, barcode, pence)
        command(:create).call(
          order_id: order_id,
          barcode: barcode,
          pence: pence,
          state: 'new'
        )
      end
    end
  end
end
