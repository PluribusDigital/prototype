
class FdicBankFindService 
  # DOCS    front end here: http://research.fdic.gov/bankfind/

  include HTTParty
  base_uri 'https://odata.fdic.gov/v1/financial-institution'

  def self.search_base_path
    '/Bank?$format=json&$inlinecount=allpages'
  end

  def self.institution_base_path
    '/Institution?$format=json'
  end

  def self.zip_search(zipcode)
    url = search_base_path + "&$filter=(startswith(zip," + zipcode.to_s + "))"
    self.get(url)['d']['results']
  end

  def self.branches_near_zip(zipcode)
    url = search_base_path + "&$filter=(startswith(zip," + zipcode.to_s + "))"
    self.get(url)['d']['results']
  end

  def self.find(id)
    url = institution_base_path + "&$filter=certNumber%20eq%20" + id.to_s
    self.get(url)['d']['results'].first  #["results"].first
  end


# branches 
# https://odata.fdic.gov/v1/financial-institution/Branch?$format=json&$inlinecount=allpages&$filter=certNumber%20eq%2011578%20and%20startswith(zip,22046)&$callback=jQuery17208486973764374852_1425926913627&sEcho=1&iColumns=11&sColumns=&iDisplayStart=0&iDisplayLength=20&mDataProp_0=id&mDataProp_1=branchNum&mDataProp_2=branchName&mDataProp_3=address&mDataProp_4=county&mDataProp_5=city&mDataProp_6=state&mDataProp_7=function&mDataProp_8=function&mDataProp_9=function&mDataProp_10=function&sSearch=&bRegex=false&sSearch_0=&bRegex_0=false&bSearchable_0=true&sSearch_1=&bRegex_1=false&bSearchable_1=true&sSearch_2=&bRegex_2=false&bSearchable_2=true&sSearch_3=&bRegex_3=false&bSearchable_3=true&sSearch_4=&bRegex_4=false&bSearchable_4=true&sSearch_5=&bRegex_5=false&bSearchable_5=true&sSearch_6=&bRegex_6=false&bSearchable_6=true&sSearch_7=&bRegex_7=false&bSearchable_7=true&sSearch_8=&bRegex_8=false&bSearchable_8=true&sSearch_9=&bRegex_9=false&bSearchable_9=true&sSearch_10=&bRegex_10=false&bSearchable_10=true&iSortCol_0=6&sSortDir_0=asc&iSortCol_1=5&sSortDir_1=asc&iSortingCols=2&bSortable_0=true&bSortable_1=true&bSortable_2=true&bSortable_3=true&bSortable_4=true&bSortable_5=true&bSortable_6=true&bSortable_7=true&bSortable_8=true&bSortable_9=true&bSortable_10=true&%24skip=0&%24top=20&%24orderby=state+asc%2Ccity+asc&_=1425927079178
end