# Sales processing design challenge

## Actors

* Sales person
* Company owning products
* Commission platform

## Requirements

* Sales person sells a product. They get a commission based on agreed conditions, from the company. The commission platform receives an agreed (with the company) N% from each commission too. 
* Sales people can sell products from different companies
* The company can see, each month, how much they need to pay to each sales person and why
* The platform admins can see how much they will charge the companies
* The sales person knows at any moment how much of their sales they made - how much commission was made

## What ifs

* we get a sale information, but the product was not provided yet?
* we get a sale info, but we don't have the commission agreement with the sales man?
* what if the commission agreement can change, also back in time?

## Contexts

### SaleConditions

* consume <-
* actions **
  - propose(sku, commission, sales_person_id)
  - agree(sku, sales_person_id)
* emit ->
  - ConditionsProposed
    - :product_sku
    - :commission_percentage
    - :sales_person_id
  - ConditionsAgreed
    - :product_sku
    - :commission_percentage
    - :sales_person_id

### SalesRecord

* consume <-
  - ConditionsAgreed
  - ProductStocked
* actions **
  - record_sale(sales_person_id, sku)
* emit ->
  - SaleRecorded
    - :sales_person_id
    - :product_sku
  - RecordedSalePriced
    - :product_sku
    - :sales_person_id
    - :product_price_cents

### Products

* consume <-
* actions **
  - stock(sku, cents)
* emit ->
  - ProductStocked
    - :product_sku
    - :price_cents

### SaleStaff

* consume <-
* actions **
  - hire_sales_person(id, email)
* emit ->
  - SalesPersonHired
    - :sales_person_id
    - :email

## Read Models

### SalesCommissionReport

* attrs
  - :sales_person_id
  - :total_cents
  - :total_commission_cents

* consume <-
  - RecordedSalePriced
  - ConditionsAgreed
  - SalesPersonHired

### SalesSystemAccess

* attrs
  - :email

* consume <-
  - SalesPersonHired

