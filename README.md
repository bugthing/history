# Payments & Fulfillment

Here is small example Ruby app of some DDD based flow for Paymente and Fulfillment.

## Usage

You need to setup db first

    export DATABASE_URL=sqlite://./tmp/db.sqlite
    bundle exec rake -T 
    bundle exec rake db:setup
    bundle exec rake db:migrate

You can run some specs:

    bundle exec rspec

or you can use the console like so:

    ./bin/console

You can call service objects (any ruby code infact) and view the events

## NOTES

### Orders

Handle the building of an order which can be paid for and fulfilled.

#### Subscription

Payments::ChargeCreditCardSucceeded => MarkOrderPaid
Fulfilment::ReleaseOrderSucceeded => MarkOrderFulfilled

#### Commands

AddOrderItem
PlaceOrder
MarkOrderPaid
MarkOrderFulfilled

#### Aggregate

Order

#### Events

AddOrderItemSucceeded
AddOrderItemFailed
PlaceOrderSucceeded
PlaceOrderFailed

#### Read Models

OrderLines

### Fulfillment

Handle the preparation of order so they can be fulfilled.

#### Subscription

Order::MarkOrderPaidSucceeded => PrepareOrder

#### Commands

PrepareOrder
ScanOrderItem
ReleaseOrder

#### Aggregate

OrderFulfillment

#### Events

PrepareOrderSucceeded
PrepareOrderFailed

#### Read Models

Fulfilment

### Payments

Handle the processing of credit card payments for orders.

#### Commands

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

#### Aggregate

CreditCardPayment

#### Events

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

#### Read Models

Transaction
