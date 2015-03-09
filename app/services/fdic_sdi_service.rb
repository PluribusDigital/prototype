class FdicSdiService < ServiceCache
  # DATA https://www2.fdic.gov/sdi/download_large_list_outside.asp
  # DOCS https://www2.fdic.gov/sdi/index.asp

  def self.read_files
    Dir.entries(data_directory).each do |filename|
      if is_matching_file? filename
        csv = CSV.parse( File.read(data_directory+filename) , headers:true )
        csv.each{ |row| write_cache row["cert"], row.to_h }
      end
    end
  end

  def self.read_definitions
    filename = Dir.entries(data_directory).select{|fn|fn[-10..-1]=="readme.htm"}.first
    page     = Nokogiri::HTML(open(data_directory+filename))   
    i = 0
    page.css("tr").each do |htmlrow|
      # it is either a subhead, column label, or the data row
      # we want to parse the subhead or data row, ignore col labels
      puts i.to_s + " | " + htmlrow.css("td").first.css("a").text.to_s
      if htmlrow.css("td").first["colspan"] == "3"
        # colspan 3 -> capture the category 
        category = htmlrow.css("td").first.text.strip
        print category
      elsif htmlrow.css("td").first.css("a").text.strip.present?
        # first cell is <a> -> capture the data and save
        help_link = htmlrow.css("td")[0].css("a").first["href"]
        name      = htmlrow.css("td")[1].text.strip
        label     = htmlrow.css("td")[2].text.strip
        write_cache "data_dictionary", {"#{name}": {'category': category, 'help_link': help_link, 'name': name, 'label': label}}
      end
      i +=1
      break if i > 30
    end 
  end

private

  def self.data_directory
    "data/fdic_sdi/"
  end

  def self.is_matching_file?(filename)
    filename[-4..-1] == ".csv"
  end

end