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
      create_order_items = RubyEventStore::ROM.env.rom_container.commands[:order_items][:create]
      create_order_items.call([{ order_id: event.data[:order_id],
                          barcode: event.data[:barcode],
                          pence: event.data[:pence],
                          state: 'new' }])
    end

    Application.event_store.subscribe(to: [Fulfillment::Events::OrderFulfillmentComplete]) do |event|

      # Figure out how to do updates in RomRB
      #update_order_items = RubyEventStore::ROM.env.rom_container.commands[:order_items][:update]
      #update_order_items.(order_id: event.data[:order_id]).call(
      #  state: 'fulfilled'
      #)
    end
  end
end
