from conexion import conexion
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
#party.name = 'pepito perez'

#Agregar campo relacionado (idioma)
Lang = Model.get('ir.lang')
es, = Lang.find([('code', '=', 'es')])
party.lang = es

#Crear y agregar campo relacionado
#address = party.address.new(city='Buga', country=50, name='edif')

#Buscar y actualizar x campo epecifico
#tercero = party.find([('code', '=', '10')])
#terceros[0]._on_change_set('name', 'pablo perea')

#Guardar cambios en el modulo
#party.save()

tercero = []
try:
    with conexion.cursor() as cursor:
        query = cursor.execute("SELECT TOP(5) * FROM dbo.TblTerceros")
        for t in query.fetchall():
            data = [t[1], t[2]]
            tercero.append(data)
except Exception as e:
    print("Error consulta: ", e)
finally:
    conexion.close()

try:
    with conexion.cursor() as cursor:
        for d in tercero:
            query = cursor.execute("SELECT TOP(5) * FROM dbo.TblTerceros_Dir WHERE nit="+d[1])
            print(query.fetchall())
except Exception as e:
    print("Error consulta: ", e)
finally:
    conexion.close()