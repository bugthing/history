module Orders
  module ReadModels
    class OrderItems < ROM::Repository[:order_items]
      def query(conditions)
        order_items.where(conditions).to_a
      end
    end
  end
end
