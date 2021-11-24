# Install Presik modules
echo "[INFO] Installing trytonpsk modules... "

modules="
    account_co_pyme
    account_col
    electronic_invoice_co
    account_voucher
    account_bank_statement
    party_personal
    company_department
    staff
    staff_co
    staff_event
    staff_payroll
    staff_payroll_access
    staff_payroll_co
    staff_contracting
    staff_access
    staff_access_extratime
    electronic_payroll
    email
"

for i in ${modules}
    do
        cd trytonpsk-$i
        git pull
        cd ..
    done
echo "[INFO] Update Done. "

for i in ${modules}
    do
        pip uninstall -y trytonpsk-$i
    done
echo "[INFO] Uninstall Complete !"

for i in ${modules}
    do
        cd trytonpsk-$i
        python3 setup.py install
        cd ..
    done
echo "[INFO] Install Complete !"