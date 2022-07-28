from models import Customers
from connection import MSSQL
import pandas as pd

customers = [Customers().to_dict() for n in range(5)]

df = pd.DataFrame.from_dict(customers)

MSSQL().pandas_to_table(df, "customers", "dbo")