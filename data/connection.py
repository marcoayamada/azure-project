import urllib
import os
from sqlalchemy import create_engine, schema
from pandas import DataFrame
from dotenv import load_dotenv

load_dotenv()

mssql = os.getenv("MSSQL")

class MSSQL():
  def __init__(self):
    self.conn_str = 'mssql+pyodbc:///?odbc_connect={}'.format(urllib.parse.quote_plus(mssql))
  
  def create_schema(self, schemaname: str):
    engine = create_engine(self.conn_str, echo=False)
    if schemaname not in engine.dialect.get_schema_names(engine):
      engine.execute(schema.CreateSchema(schemaname))
      return True
    return False

  def pandas_to_table(self, dataframe: DataFrame, table: str, schema: str):
    # self.create_schema(schema)
    return dataframe.to_sql(table, schema=schema, con=self.conn_str, index=False, if_exists="append")