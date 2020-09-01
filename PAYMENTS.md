# Payments & Fulfillment

## Order

Handle the building or an order which can be paid for and fulfilled.

### Subscription

Payments::ChargeCreditCardSucceeded => MarkOrderPaid
Fulfilment::ReleaseOrderSucceeded => MarkOrderFulfilled

### Commands

AddOrderItem
PlaceOrder
MarkOrderPaid
MarkOrderFulfilled

### Aggregate

Order

### Events

AddOrderItemSucceeded
AddOrderItemFailed
PlaceOrderSucceeded
PlaceOrderFailed

### Read Models

OrderLines

## Fulfillment

Handle the preparation of order so they can be fulfilled.

### Subscription

Order::MarkOrderPaidSucceeded => PrepareOrder

### Commands

PrepareOrder
ScanOrderItem
ReleaseOrder

### Aggregate

OrderFulfillment

### Events

PrepareOrderSucceeded
PrepareOrderFailed

### Read Models

Fulfilment

## Payments

Handle the processing of credit card payments for orders.

### Commands

ChargeCreditCard
  number
  expiry
  cvv
  name
  address
  postcode
  amount
  order_id

AuthorizeCreditCard

CaptureAuthorization

VoidAuthorization

RefundPayment

### Aggregate

CreditCardPayment

### Events

ChargeCreditCardSucceeded
ChargeCreditCardFailed
AuthorizeCreditCardSucceeded
AuthorizeCreditCardFailed
CaptureAuthorizationSucceeded
CaptureAuthorizationFailed
VoidAuthorizationSucceeded
VoidAuthorizationFailed
RefundPaymentSucceeded
RefundPaymentFailed

### Read Models

Transaction
