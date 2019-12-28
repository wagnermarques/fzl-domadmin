
rem https://technet.microsoft.com/en-us/library/aa905872%28v=sql.80%29.aspx
rem Connecting to a SQL Server Data Source SQL Server 2000
rem New Information - SQL Server 2000 SP3.


rem ADO can use any OLE DB provider to establish a connection. 
rem The provider is specified through the Provider property of the Connection object.
rem Microsoft® SQL Server™ 2000 applications use SQLOLEDB to connect to an instance of SQL Server, although existing applications can also use MSDASQL to maintain backward compatibility



Const adOpenStatic = 3 
Const adLockOptimistic = 3 

Const datasource="dmplight"
Const initialCatalog="testdb"
Const dbUserName="not_too_common_username"
Const dbUserPassword="verys3cretp@ssw0rd"

 
Set objConnection = CreateObject("ADODB.Connection") 
Set objRecordSet = CreateObject("ADODB.Recordset") 
 
objConnection.Open _ 
    "Provider=SQLOLEDB;Data Source=" &datasource& ";" & _ 
        "Trusted_Connection=Yes;Initial Catalog=" &initialCatalog& ";" & _ 
             "User ID="&dbUserName&";Password="&dbUserPassword&";" 
 
objRecordSet.Open "SELECT * FROM Table_1", _ 
        objConnection, adOpenStatic, adLockOptimistic 
 
objRecordSet.MoveFirst 
 
Wscript.Echo objRecordSet.RecordCount 