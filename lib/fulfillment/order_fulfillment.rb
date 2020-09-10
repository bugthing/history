module Fulfillment
  class OrderFulfillment
    include AggregateRoot

    Error = Class.new(StandardError)

    def initialize(id)
      @id = id
      @barcodes = []
      @scanned_barcodes = []
    end

    def prepare_order(cmd)
      apply(Events::PrepareOrderSucceeded.new(data: cmd.attributes.to_hash))
    end

    def scan_order_item(cmd)
      apply(Events::ScanSucceeded.new(data: cmd.attributes.to_hash))
      apply(Events::OrderFulfillmentComplete.new(data: { 
        order_id: @id,
      })) if all_items_scanned?
    end

    def apply_prepare_order_succeeded(event)
      @barcodes = event.data[:barcodes]
    end

    def apply_scan_succeeded(event)
      @scanned_barcodes << event.data[:barcode]
    end

    def apply_order_fulfillment_complete(event)
    end

    def all_items_scanned?
      (@barcodes - @scanned_barcodes).empty?
    end
  end
end
