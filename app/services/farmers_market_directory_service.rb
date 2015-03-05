class FarmersMarketDirectoryService 
  # DOCS    http://search.ams.usda.gov/farmersmarkets/v1/svcdesc.html

  include HTTParty
  base_uri 'http://search.ams.usda.gov'

  def self.base_path
    '/farmersmarkets/v1/data.svc/'
  end

  def self.zip_search(zipcode)
    url = base_path + "zipSearch?zip=" + zipcode.to_s
    parse_marketname self.get(url)['results']
  end

  def self.lat_long_search(lat,long)
    url = base_path + "locSearch?lat=" + lat.to_s + "&lng=" + long.to_s
    parse_marketname self.get(url)['results']
  end

  def self.find(id)
    url = base_path + "mktDetail?id=" + id
    self.get(url)["marketdetails"]
  end

private

  def self.parse_marketname(result_set)
    # parsing out miles at front of string, examples:
    #   0.9 Anytown farmers market
    #   1.5 Nexttown market tuesdays
    distance_regex = /^\d+\.*\d+/ 
    result_set.map do |item| 
      {
        id:       item['id'],
        distance: item['marketname'].match(distance_regex).to_s,
        name:     item['marketname'].gsub(distance_regex,"")
      }
    end
  end

end