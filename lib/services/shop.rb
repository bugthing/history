module Services
  module Shop
    module_function
    def add_item(order_id, barcode, pence)
      Orders::Commands::AddItem.call(order_id: order_id, barcode: barcode, pence: pence)
    end

    def scan(order_id, barcode)
      Fulfillment::Commands::ScanOrderItem.call(order_id: order_id, barcode: barcode)
    end

    def charge_card(order_id,
                    number,
                    expiry,
                    cvv,
                    name,
                    address,
                    postcode,
                    pence)
      Payments::Commands::ChargeCreditCard.call(order_id: order_id,
                                                number: number,
                                                expiry: expiry,
                                                cvv: cvv,
                                                name: name,
                                                address: address,
                                                postcode: postcode,
                                                pence: pence)
    end
  end
end
