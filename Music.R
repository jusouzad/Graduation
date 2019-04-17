path = 'C:/Users/177105/Downloads'
fname = file.path(path, "disco.db")

library(RSQLite)

conn = dbConnect(SQLite(), fname)

dbListFields(conn, 'customers')

clientes = dbGetQuery(conn, 'SELECT CustomerId FROM customers')
paises = dbGetQuery(conn, 'SELECT DISTINCT Country FROM customers ORDER BY Country')

dbGetQuery(conn, 'SELECT Country, COUNT(CustomerId) FROM customers GROUP BY Country ORDER BY COUNT(CustomerId) DESC LIMIT 5')
nome = dbGetQuery(conn, 'SELECT DISTINCT Country FROM customers WHERE LENGTH(TRIM(Country)) = 6')
sql = paste('SELECT DISTINCT name FROM invoice_items', 'INNER JOIN tracks ON tracks.trackid = invoice_items.trackid', 'WHERE invoiceid IN', '(SELECT DISTINCT InvoiceId FROM customers', 'INNER JOIN invoices ON invoices.customerid =customers.customerid', 'WHERE country="Brazil")')
dbGetQuery(conn, sql)

dbDisconnect(conn)
