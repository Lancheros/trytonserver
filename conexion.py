import pyodbc

server = 'tcp:186.115.69.213,10433'
db = 'DEMO'
user = 'sa'
password = '3.1416.asd*'

try:
    conexion = pyodbc.connect('DRIVER={ODBC Driver 17 for SQL Server};SERVER='+server+';DATABASE='+db+';UID='+user+';PWD='+password)

    print("Conexion exitosa !")

except Exception as e:
    print("Ocurrio un error al conectar SQL Server: ", e)

