class SocialSecurityBeneficiaryService < ServiceCache
  # DATA  http://www.ssa.gov/policy/docs/statcomps/oasdi_zip/2013/oasdi_zip13.xlsx
  # DOCS  http://www.huduser.org/portal/datasets/usps_crosswalk.html
  #       https://catalog.data.gov/dataset/oasdi-beneficiaries-by-state-and-zip-code

  def self.read_workbook
    puts "reading workbook "
    workbook = RubyXL::Parser.parse(data_file)
    n = 1
    puts "parsing worksheets "
    workbook.each do |sheet|
      parse_worksheet sheet.extract_data 
      print " .. " + n.to_s
      n+=1
    end
    puts "Victory is Ours!"
  end

  def self.parse_worksheet(worksheet)
    consecutive_nil_rows  = 0
    row_index             = 5 ## Start at Row 5 becaues of OASDI spreadsheet layout & header rows
    while consecutive_nil_rows < 10 do 
      row         = worksheet[row_index]
      zip         = row[1]
      is_data_row = !zip.nil?
      if is_data_row
        data = Hash[ column_map.map{|k,v| [ v, row[k] ] } ]
        write_cache clean_zip(zip) , data 
        consecutive_nil_rows=0
      else
        consecutive_nil_rows+=1
      end
      row_index +=1
    end
    return true
  end

private 

  def self.data_file
    'data/social_security_beneficiary/oasdi_zip13.xlsx'
  end

  def self.column_map
    {
      3 => 'Total',
      4 => 'Retired workers',
      5 => 'Disabled workers',
      6 => 'Widow(er)s and parents',
      7 => 'Spouses',
      8 => 'Children',
      9 => 'Total Monthly Benefits - All beneficiaries',
      10 => 'Total Monthly Benefits - Retired workers ',
      11 => 'Total Monthly Benefits - Widow(er)s and parents',
      12 => 'Number of OASDI beneficiaries aged 65 or older'
    }
  end

  def self.clean_zip(zip)
    z = zip.to_s
    zero_pad = (z.length < 5) ? "0"*(5-z.length) : ""
    return zero_pad + z
  end

end