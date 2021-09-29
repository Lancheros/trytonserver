#!/bin/sh

#---------------------------------------------------------
#    Script Install Tryton Server
# --------------------------------------------------------

# Note: run this script with as user (not root), so doesn't use sudo for run it
# Main functions/variables declaration

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


echo '----------------------------------------------------------'
#read -p 'Introduce the tryton name user: ' nameuser
version='6.0'
max_version='6.1'

integer_version='60'
venv='tryton'${integer_version}
nameuser=$SUDO_USER
HOME_USER=/home/cdst
file_bashrc=$HOME_USER'/.bashrc'

PYT_CMD=$HOME_USER/.virtualenvs/${venv}/bin/python3

# apt get update

# Install PIP packages
PIP_CMD=$HOME_USER/.virtualenvs/${venv}/bin/pip3

source_="\nalias workon='source ~/.virtualenvs/$venv/bin/activate'"
export_="\nexport WORKON_HOME=$HOME_USER/.virtualenvs"

# Install apt-get packages
message "[INFO] Installing main apt-get packages..." ${BLUE}
appackages="
        git
	build-essential
	python3-pip
  python3-dev
  python3-venv
	python-setuptools
	postgresql
	postgresql-server-dev-12
	libffi-dev
  libpq-dev
	libxml2-dev
	libxslt-dev
	python3-ldap
	python3-dateutil
	python3-lxml
	python3-polib
	python3-psycopg2
	python3-genshi
	python3-sql
	python3-tz
	python3-stdnum
	python3-virtualenv
	python3-simplejson
	python3-pil
  python3-magic
	sqlite3
	unoconv
  virtualenv
	libjansson4
  python3-gi
	python3-gi-cairo
        libcairo2-dev
        gir1.2-goocanvas-2.0
        gunicorn
        libgirepository1.0-dev
"

for i in ${appackages}
    do
        sudo apt -y install $i
    done
message "[INFO] Done." ${YELLOW}


# Create Virtualenv
message "[INFO] Creating virtualenv... $venv " ${BLUE}

echo $source_ >> $file_bashrc
echo $export_ >> $file_bashrc

python -m venv $HOME_USER/.virtualenvs/${venv}

message "[INFO] Done." ${YELLOW}

# Install PIP package
message "[INFO] Installing main PIP packages..." ${BLUE}

sudo pip install -U pip
sudo pip3 install -U pip

pippackages="
    bcrypt
    pytz
    wrapt
    polib
    python-stdnum
    jinja2
    python-sql
    psycopg2
    psycopg2cffi
    zeep
    psk_numword
    vobject
    simpleeval
    cached-property
    relatorio
    chardet
    passlib
    requests
    psycopg2-binary
    simplejson
    pycrypto
    flask
    flask_tryton
    flask_cors
    Werkzeug
    sendgrid
    suds-py3
    beautifulsoup4
    qrcode
    cryptography
    pyOpenSSL
    pycountry
"

for i in ${pippackages}
    do
        ${PIP_CMD} install $i
    done

message "[INFO] Creating Predash directory and files..." ${BLUE}
mkdir $HOME_USER/.flask
mkdir $HOME_USER/.certificate
mkdir $HOME_USER/predash

cd predash
git clone https://presik@bitbucket.org/presik/predash-api.git

cp predash-api/dash.ini ~/.flask/dash.ini
sudo cp predash-api/predash_api.service /etc/systemd/system/predash_api.service
sudo chmod 755 /etc/systemd/system/predash_api.service
sudo systemctl enable predash_api.service


git clone https://presik@bitbucket.org/presik/kid.git
cd kid
sudo cp kid.service /etc/systemd/system/kid.service
sudo chmod 755 /etc/systemd/system/kid.service

sudo systemctl enable kid.service

message "[INFO] Done." ${YELLOW}


# Create directories for tryton environment
message "[INFO] Creating tryton target directories... " ${BLUE}
CONFIG_DIR="$HOME_USER/.trytond"
ATTACH_DIR="$HOME_USER/.attach"
BACKUP_DIR="$HOME_USER/.backups"
SCRIPTS_DIR="$HOME_USER/.scripts"

mkdir ${CONFIG_DIR}
chown -R ${nameuser}:${nameuser} ${CONFIG_DIR}

mkdir ${ATTACH_DIR}
chmod 755 ${ATTACH_DIR}

mkdir ${BACKUP_DIR}
chmod 755 ${BACKUP_DIR}

mkdir ${SCRIPTS_DIR}
chmod 755 ${SCRIPTS_DIR}

message "[INFO] Downloading install scripts... " ${BLUE}
git clone https://presik@bitbucket.org/presik/work_scripts.git
cd work_scripts

mv backup_db.sh $SCRIPTS_DIR
mv vacuum_db.sh $SCRIPTS_DIR

cp trytond.conf ${CONFIG_DIR}/trytond.conf
chmod 755 ${CONFIG_DIR}/trytond.conf

message "[INFO] Done." ${YELLOW}

tryton_modules="
    trytond
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
    proteus
"

message "[INFO] Installing official Tryton packages..." ${BLUE}
for i in ${tryton_modules}
do
    ${PIP_CMD} install "$i>=$version,<$max_version" --no-deps
done
message "[INFO] Done. " ${YELLOW}

# Copying initializing install server script
message "[INFO] Setting initializing trytond server... " ${BLUE}
DAEMON=$HOME_USER/.virtualenvs/${venv}/bin/trytond
SETTING='-c $HOME_USER/.trytond/trytond.conf'
init_cmd="su ${nameuser} -c '${DAEMON} ${SETTING}'"

# Changing owner of new virtualenv
message "[INFO] Changing owner of virtualenv... " ${BLUE}
chown $nameuser:$nameuser -R $HOME_USER/.virtualenvs/
message "[INFO] Done." ${YELLOW}


#Change permissions of /var/lib/trytond
message "[INFO] Changing permissions of /var/lib/trytond... " ${BLUE}
mkdir /var/lib/trytond
chown ${nameuser}:${nameuser} /var/lib/trytond
chmod -R 755 /var/lib/trytond


# Initializing server

sudo cp strytond.service /etc/systemd/system/strytond.service
sudo chmod 755 /etc/systemd/system/strytond.service

sudo cp strytond_service /usr/local/bin/strytond_service
sudo chmod 755 /usr/local/bin/strytond_service

sudo systemctl enable strytond.service
message "[INFO] Done." ${YELLOW}

message "[INFO] Starting trytond server... " ${BLUE}
sudo systemctl start strytond.service
message "[INFO] Ok." ${YELLOW}

sudo systemctl status strytond.service


message "[INFO] Adding script backup and maintenance of database... " ${BLUE}
sed -i "s/DEMO/${new_db}/g" backup_db.sh
cp backup_db.sh $HOME_USER/.scripts/backup_db.sh
chmod 755 $HOME_USER/.scripts/backup_db.sh
echo "10 8   * * *	$SUDO_USER    $HOME_USER/.scripts/backup_db.sh" > /etc/crontab
echo "[INFO] Done."


echo
message "[INFO] Your Tryton Server is ready...!" ${YELLOW}

# Add currencies to database
# trytond_import_currencies -c ~/.trytond/trytond.conf -d DEMO60
