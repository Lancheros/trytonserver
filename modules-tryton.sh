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

version='6.0'
max_version='6.1'

integer_version='6'
venv='tryton'${integer_version}
HOME_USER=/home/trytonserver_1

PYT_CMD=$HOME_USER/${venv}/bin/python3

#apt get update

# Install PIP packages
PIP_CMD=$HOME_USER/${venv}/bin/pip3

tryton_modules="
    trytond_country
    trytond_party
    trytond_currency
    trytond_company
    trytond_product
    trytond_stock
    trytond_account
    trytond_account_product
    trytond_account_invoice
    trytond_account_invoice_history
    trytond_account_statement
    trytond_account_invoice_stock
    trytond_account_asset
    trytond_bank
    trytond_account_payment
    trytond_product_cost_fifo
    trytond_product_cost_history
    trytond_product_price_list
    trytond_product_attribute
    trytond_stock_forecast
    trytond_stock_inventory_location
    trytond_stock_product_location
    trytond_stock_location_sequence
    trytond_stock_product_location
    trytond_purchase
    trytond_purchase_request
    trytond_purchase_requisition
    trytond_purchase_shipment_cost
    trytond_production
    trytond_stock_supply
    trytond_stock_supply_day
    trytond_stock_supply_forecast
    trytond_sale
    trytond_sale_supply
    trytond_sale_opportunity
    trytond_sale_price_list
    trytond_sale_invoice_grouping
    trytond_sale_credit_limit
    trytond_analytic_account
    trytond_analytic_invoice
    trytond_analytic_purchase
    trytond_analytic_sale
    trytond_account_credit_limit
    trytond_commission
    trytond_timesheet
    trytond_company_work_time
    trytond_project
    trytond_carrier
    trytond_account_be
    trytond_account_deposit
    trytond_account_de_skr03
    trytond_account_durning
    trytond_account_durning_email
    trytond_account_durning_free
    trytond_account_durning_letter
    trytond_account_invoice_line_standalone
    trytond_account_payment_clearing
    trytond_account_payment_sepa
    trytond_account_payment_sepa_cfonb
    trytond_account_stock_anglo_saxon
    trytond_account_stock_continental
    trytond_account_stock_landed_cost
    trytond_account_stock_landed_cost_weight
    trytond_account_tax_rule_country
    trytond_authentication_sms
    trytond_carrier_percentage
    trytond_carrier_weight
    trytond_comission
    trytond_comission_waiting
    trytond_customs
    trytond_dashboard
    trytond_edocument_uncefact
    trytond_edocument_unece
    trytond_google_maps
    trytond_ldap_authentication
    trytond_notification_email
    trytond_party_relationship
    trytond_party_siret
    trytond_product_classification_taxonomic
    trytond_product_measurements
    trytond_production_routing
    trytond_production_work
    trytond_project_invoice
    trytond_project_plan
    trytond_project_revenue
    trytond_purchase_invoice_line_standalone
    trytond_sale_complaint
    trytond_sale_extra
    trytond_sale_promotion
    trytond_sale_shipment_cost
    trytond_sale_shipment_grouping
    trytond_sale_stock_quantity
    trytond_sale_subscription
    trytond_sale_supply_drop_shipment
    trytond_stock_lot_sled
    trytond_stock_package
    trytond_stock_package_shipping
    trytond_stock_package_shipping_dpd
    trytond_stock_package_shipping_ups
    trytond_stock_shipment_measurements
    trytond_stock_split
    trytond_stock_supply_production
    trytond_timesheet_cost
    trytond_user_role
    trytond_web_shortener
    trytond_web_user
    trytond_account_cash_rounding
"

message "[INFO] Installing official Tryton packages..." ${BLUE}
for i in ${tryton_modules}
do
    ${PIP_CMD} install "$i>=$version,<$max_version" --no-deps
done
message "[INFO] Done. " ${YELLOW}

