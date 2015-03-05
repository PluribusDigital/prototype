class FoodEnvironmentAtlasService < ServiceCache
  # DATA http://www.ers.usda.gov/datafiles/Food_Environment_Atlas/Data_Access_and_Documentation_Downloads/Current_Version/DataDownload.xls
  # DOCS http://www.ers.usda.gov/data-products/food-environment-atlas/data-access-and-documentation-downloads.aspx

  def self.read_file
    counties = JSON.parse File.read(data_file)
    counties.each do |county|
      write_cache county["FIPS"], county
    end
  end

private

  def self.data_file
    'data/food_environment_atlas/stores.json'
  end

end