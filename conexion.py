import pyodbc

server = 'tcp:192.168.1.127,10433'
db = 'TecnoCarnes'
user = 'sa'
password = '3.1416.asd*'

try:
    conexion = pyodbc.connect('DRIVER={ODBC Driver 17 for SQL Server};SERVER='+server+';DATABASE='+db+';UID='+user+';PWD='+password)

    print("\n")
    print("Conexion exitosa !")
    print("\n")

except Exception as e:
    print("Ocurrio un error al conectar SQL Server: ", e)

