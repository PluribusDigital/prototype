class WmataService

  # DOCS    https://developer.wmata.com/docs/services/

  include HTTParty
  base_uri 'https://api.wmata.com'

  def self.api_key
    ENV["WMATA_API_KEY"]
  end

  def self.arrivals(station_code)
    # station code is string, either single code or comma-seperated list of codes
    url = '/StationPrediction.svc/json/GetPrediction/' + station_code + "?api_key=" + api_key  
    self.get(url)
  end

end