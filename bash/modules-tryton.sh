#!/bin/sh

#---------------------------------------------------------
#    Script Install Tryton All Modules 
# --------------------------------------------------------

# Colors constants
NONE="$(tput sgr0)"
RED="$(tput setaf 1)"
GREEN="$(tput setaf 2)"
YELLOW="$(tput setaf 3)"
BLUE="$(tput setaf 4)"

message () {
    # $1 : Message
    # $2 : Color
    # return : Message colorized
    local NOW="[$(date +%H:%M:%S)] "

    echo "${2}${NOW}${1}${NONE}"
}

echo '----------------------------------Inicio----------------------------------'

version='6.0.0'

#https://downloads.tryton.org/6.0/modules.txt
tryton_modules="
    account
    account_asset
    account_be
    account_cash_rounding
    account_credit_limit
    account_deposit
    account_de_skr03
    account_dunning
    account_dunning_email
    account_dunning_fee
    account_dunning_letter
    account_es
    account_eu
    account_fr
    account_fr_chorus
    account_invoice
    account_invoice_correction
    account_invoice_defer
    account_invoice_history
    account_invoice_line_standalone
    account_invoice_secondary_unit
    account_invoice_stock
    account_payment
    account_payment_braintree
    account_payment_clearing
    account_payment_sepa
    account_payment_sepa_cfonb
    account_payment_stripe
    account_product
    account_statement
    account_statement_aeb43
    account_statement_coda
    account_statement_ofx
    account_statement_rule
    account_stock_anglo_saxon
    account_stock_continental
    account_stock_landed_cost
    account_stock_landed_cost_weight
    account_tax_cash
    account_tax_rule_country
    analytic_account
    analytic_invoice
    analytic_purchase
    analytic_sale
    attendance
    authentication_sms
    bank
    carrier
    carrier_percentage
    carrier_subdivision
    carrier_weight
    commission
    commission_waiting
    company
    company_work_time
    country
    currency
    customs
    dashboard
    edocument_uncefact
    edocument_unece
    google_maps
    incoterm
    ldap_authentication
    marketing
    marketing_automation
    marketing_email
    notification_email
    party
    party_avatar
    party_relationship
    party_siret
    product
    product_attribute
    product_classification
    product_classification_taxonomic
    product_cost_fifo
    product_cost_history
    product_cost_warehouse
    product_kit
    production
    production_outsourcing
    production_routing
    production_split
    production_work
    production_work_timesheet
    product_measurements
    product_price_list
    product_price_list_dates
    product_price_list_parent
    project
    project_invoice
    project_plan
    project_revenue
    purchase
    purchase_amendment
    purchase_history
    purchase_invoice_line_standalone
    purchase_price_list
    purchase_request
    purchase_request_quotation
    purchase_requisition
    purchase_secondary_unit
    purchase_shipment_cost
    sale
    sale_advance_payment
    sale_amendment
    sale_complaint
    sale_credit_limit
    sale_discount
    sale_extra
    sale_gift_card
    sale_history
    sale_invoice_grouping
    sale_opportunity
    sale_payment
    sale_price_list
    sale_product_customer
    sale_promotion
    sale_promotion_coupon
    sale_secondary_unit
    sale_shipment_cost
    sale_shipment_grouping
    sale_shipment_tolerance
    sale_stock_quantity
    sale_subscription
    sale_subscription_asset
    sale_supply
    sale_supply_drop_shipment
    sale_supply_production
    stock
    stock_assign_manual
    stock_consignment
    stock_forecast
    stock_inventory_location
    stock_location_move
    stock_location_sequence
    stock_lot
    stock_lot_sled
    stock_lot_unit
    stock_package
    stock_package_shipping
    stock_package_shipping_dpd
    stock_package_shipping_ups
    stock_product_location
    stock_quantity_early_planning
    stock_quantity_issue
    stock_secondary_unit
    stock_shipment_cost
    stock_shipment_measurements
    stock_split
    stock_supply
    stock_supply_day
    stock_supply_forecast
    stock_supply_production
    timesheet
    timesheet_cost
    user_role
    web_shop
    web_shop_vue_storefront
    web_shop_vue_storefront_stripe
    web_shortener
    web_user
"

message "[INFO] Installing official Tryton packages..." ${BLUE}
for i in ${tryton_modules}
do
    pip install --no-cache-dir trytond_$i~=${version} --no-deps
done
message "[INFO] Done. " ${YELLOW}
