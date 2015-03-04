class FarmersMarketDirectoryService
  # DOCS    http://search.ams.usda.gov/farmersmarkets/v1/svcdesc.html

  include HTTParty
  base_uri 'http://search.ams.usda.gov'

  def base_path
    '/farmersmarkets/v1/data.svc/'
  end

  def zip_search(zipcode)
    url = base_path + "zipSearch?zip=" + zipcode
    self.class.get(url)['results']
  end

  def lat_long_search(lat,long)
    url = base_path + "locSearch?lat=" + lat.to_s + "&lng=" + long.to_s
    self.class.get(url)['results']
  end

  def market_detail(id)
    url = base_path + "mktDetail?id=" + id
    self.class.get(url)["marketdetails"]
  end

end