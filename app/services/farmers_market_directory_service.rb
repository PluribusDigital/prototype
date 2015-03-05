class FarmersMarketDirectoryService 
  # DOCS    http://search.ams.usda.gov/farmersmarkets/v1/svcdesc.html

  include HTTParty
  base_uri 'http://search.ams.usda.gov'

  def self.base_path
    '/farmersmarkets/v1/data.svc/'
  end

  def self.zip_search(zipcode)
    url = base_path + "zipSearch?zip=" + zipcode
    self.get(url)['results']
  end

  def self.lat_long_search(lat,long)
    url = base_path + "locSearch?lat=" + lat.to_s + "&lng=" + long.to_s
    self.get(url)['results']
  end

  def self.find(id)
    url = base_path + "mktDetail?id=" + id
    self.get(url)["marketdetails"]
  end

end