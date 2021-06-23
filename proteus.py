from proteus import config, Model, Wizard, Report

config = config.set_trytond(database='cdstecno_db',
    config_file='/home/trytonserver_1/tryton/trytond.conf')

#Example
#Module = Model.get('ir.module')
#party_module, = Module.find([('name', '=', 'party')])
#party_module.click('activate')
#Wizard('ir.module.activate_upgrade').execute('upgrade')

#Create
Party = Model.get('party.party')
party = Party()
party.name = 'pepito perez'

#Agregar campo relacionado (idioma)
Lang = Model.get('ir.lang')
es, = Lang.find([('code', '=', 'es')])
party.lang = es

#Crear y agregar campo relacionado
address = party.address.new(city='Buga', country=50, name='edif')

#Buscar y actualizar x campo epecifico
#tercero = party.find([('code', '=', '10')])
#terceros[0]._on_change_set('name', 'pablo perea')

#Guardar cambios en el modulo
party.save()

