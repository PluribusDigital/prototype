class HealthIndicatorsService < ServiceCache
  # DOCS http://catalog.data.gov/dataset/community-health-status-indicators-chsi-to-combat-obesity-heart-disease-and-cancer
  # DOCS http://wwwn.cdc.gov/CommunityHealth/info/AboutData
  # DATA ftp://ftp.cdc.gov/pub/Health_Statistics/NCHS/Datasets/CHDI/chsi_dataset.zip

  def self.read_workbook
    puts "reading workbook "
    workbook = RubyXL::Parser.parse(data_file)
    parse_worksheet workbook['DEMOGRAPHICS'].extract_data
    puts "Victory is Ours!"
  end

  def self.parse_worksheet(worksheet)
    consecutive_nil_rows  = 0
    header_row = worksheet[0]
    row_index             = 1 
    while consecutive_nil_rows < 10 do 
      row         = worksheet[row_index]
      county      = row[0].to_s + row[1].to_s if row 
      is_data_row = row && county && county.present?
      if is_data_row
        data = Hash[ header_row.zip row ]
        write_cache county , data 
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
    'data/health_indicators/CHSI_DataSet.xlsx'
  end

end