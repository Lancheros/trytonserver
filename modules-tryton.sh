#!/bin/sh

#---------------------------------------------------------
#    Script Install Tryton All Modules 
# --------------------------------------------------------

# Colors constants
NONE="$(tput sgr0)"
RED="$(tput setaf 1)"
GREEN="$(tput setaf 2)"
YELLOW="\n$(tput setaf 3)"
BLUE="\n$(tput setaf 4)"

message () {
    # $1 : Message
    # $2 : Color
    # return : Message colorized
    local NOW="[$(date +%H:%M:%S)] "

    echo "${2}${NOW}${1}${NONE}"
}

echo '----------------------------------Inicio----------------------------------'
echo 'Ingrese el nombre del usuario: '
read SUDO_USER

version='6.0'
max_version='6.1'

integer_version='60'
venv='tryton'${integer_version}
nameuser=${SUDO_USER}
HOME_USER=/home/${SUDO_USER}/cdst
file_bashrc=$HOME_USER'/.bashrc'

PYT_CMD=$HOME_USER/.virtualenvs/${venv}/bin/python3

apt get update

# Install PIP packages
PIP_CMD=$HOME_USER/.virtualenvs/${venv}/bin/pip3

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
"

message "[INFO] Installing official Tryton packages..." ${BLUE}
for i in ${tryton_modules}
do
    ${PIP_CMD} install "$i>=$version,<$max_version" --no-deps
done
message "[INFO] Done. " ${YELLOW}

