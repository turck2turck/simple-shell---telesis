#!python3

# Libraries
import psycopg2 as pg
import sys
#import pandas.io.sql as psql

# Connection params for the atero database
hst="atero-staging-db.cvv9i14mrv4k.us-east-1.rds.amazonaws.com"
pt=5432
db="aterodb"
usr="atero_admin"
pwrd="443ih4%d7E97"
table = "loading.akeneo"
fpath = "/home/ubuntu/export/atero/"
print("Setup complete.")

# CSV file variables
csvfile = fpath + sys.argv[1]

# Add in a confirmation that the file is the correct format and correct columns (?)
print("Attempting to dock data from",csvfile)
SQL_dock_items = """
    COPY %s FROM STDIN WITH
        NULL AS ''
        DELIMITER AS ','
        HEADER
        CSV;        
    """
SQL_drop_akeneo = """
    TRUNCATE TABLE %s;
"""

# The initial dock items function before validation rules 
def dock_items(connection,tbl,fileobj):
    cur = connection.cursor()
    
    # Execute copy query to dock data
    cur.copy_expert(sql=SQL_dock_items % tbl, file=fileobj)
    # Commit and close
    connection.commit()
    cur.close()

# Truncate the data function
#def trunc_items(connection,tbl)
#    cur = connection.cursor()
#    connection.commit()
#    cur.close()

# Create the connection and dock the data
print("Connecting to database.")
conn = pg.connect(host=hst,port=pt,dbname=db,user=usr,password=pwrd)
print("Connection successful.")
print("Opening csv file.")
file = open(csvfile,encoding="utf8")

print("Docking...")
try:
    dock_items(conn,table,file)
    print("Successful dock.")
finally:
    conn.close()

# Echo back the number of records added appended to THE LOG
