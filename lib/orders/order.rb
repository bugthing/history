module Orders
  class Order
    include AggregateRoot

    Error = Class.new(StandardError)

    def initialize(id)
      @id = id
      @items = []
    end

    def add_item(cmd)
      apply(Events::AddOrderItemSucceeded.new(data: cmd.attributes.to_hash))
    end

    def apply_add_order_item_succeeded(event)
      @items << event.data
    end
  end
end
