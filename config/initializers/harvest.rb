require "harvested"

HARVEST = Harvest.hardy_client(
  subdomain:  Figaro.env.harvest_subdomain, 
  username:   Figaro.env.harvest_username, 
  password:   Figaro.env.harvest_password
)