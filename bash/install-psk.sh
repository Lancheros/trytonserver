#!/bin/sh

# Install Presik modules
echo "[INFO] Installing trytonpsk modules... "

modules="
    account_bank_statement
    account_col
    account_co_pyme
    account_invoice_discount
    account_stock_latin
    account_voucher
    company_department
    electronic_payroll
    email
    invoice_report
    party_personal
    sale_pos
    sale_pos_frontend
    sale_salesman
    sale_shop
    staff
    staff_access
    staff_access_extratime
    staff_co
    staff_contracting
    staff_event
    staff_payroll
    staff_payroll_access
    staff_payroll_co
    stock_co
"

for i in ${modules}
    do
        git clone https://bitbucket.org/presik/trytonpsk-$i.git
    done
echo "[INFO] Download completed. "

for i in ${modules}
    do
        cd trytonpsk-$i
	python3 setup.py install
	cd ..
    done
echo "[INFO] Done. "
