module Orders
  class Subscriptions
    Application.event_store.subscribe(to: [Payments::Events::ChargeCreditCardSucceeded]) do |event|

      Orders::Commands::RecordAmountPaid.call(
        order_id: event.data[:order_id],
        pence: event.data[:pence]
      )

    end

    Application.event_store.subscribe(to: [Orders::Events::OrderPaidFor]) do |event|
      Fulfillment::Commands::PrepareOrder.call(
        order_id: event.data[:order_id],
        barcodes: event.data[:barcodes]
      )
    end

    Application.event_store.subscribe(to: [Orders::Events::AddOrderItemSucceeded]) do |event|
      Application.rom_container.relations[:order_items].create(
        event.data[:order_id],
        event.data[:barcode],
        event.data[:pence]
      )
    end

    Application.event_store.subscribe(to: [Fulfillment::Events::OrderFulfillmentComplete]) do |event|
      Application.rom_container.relations[:order_items].set_fulfilled(event.data[:order_id])
    end
  end
end
