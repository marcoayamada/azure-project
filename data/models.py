from random import randint
from datetime import datetime
from faker import Faker

fake = Faker()

Faker.seed(randint(0, 1000000))


class Customers():
  __slots__ = [
    "customer_id",
    "uuid",
    "first_name",
    "last_name",
    "date_birth",
    "city",
    "country",
    "company_name",
    "job",
    "phone_number",
    "last_access_time",
    "time_zone",
    "created_at"
]

  def __init__(self):
    self.customer_id = randint(0, 1000)
    self.uuid = fake.uuid4()
    self.first_name = fake.first_name()
    self.last_name = fake.last_name()
    self.date_birth = fake.date_of_birth()
    self.city = fake.city()
    self.country = fake.country()
    self.company_name = fake.company()
    self.job = fake.job()
    self.phone_number = fake.phone_number()
    self.last_access_time = fake.iso8601()
    self.time_zone = fake.timezone()
    self.created_at = datetime.now()

  def to_dict(self):
    return {
      "customer_id": self.customer_id,
      "uuid": self.uuid,
      "first_name": self.first_name,
      "last_name": self.last_name,
      "date_birth": self.date_birth,
      "city": self.city,
      "country": self.country,
      "company_name": self.company_name,
      "job": self.job,
      "phone_number": self.phone_number,
      "last_access_time": self.last_access_time,
      "time_zone": self.time_zone,
      "created_at": self.created_at,
    }
