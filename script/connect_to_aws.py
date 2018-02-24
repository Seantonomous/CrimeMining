import pymssql
import pandas as pd

conn = pymssql.connect(server="myserver", user="", password="", database="crime", port=1433)

stmt = "SELECT TOP 10 * FROM la_crime_clean"
df = pd.read_sql(stmt,conn)

print(df)
