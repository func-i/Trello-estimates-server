require "harvested"
HARVEST = Harvest.hardy_client(Figaro.env.harvest_subdomain, Figaro.env.harvest_username, Figaro.env.harvest_password)