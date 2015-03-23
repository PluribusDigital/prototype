class JsonApi

  def ignored_params
    %w(controller action resource_name)
  end

  def search_params
    @params.select{|k,v| !ignored_params.include? k }
  end

  def initialize(params)
    @resource_name = params[:resource_name]
    @params        = params 
  end

  def file_path
    "data/json_api/" + @resource_name + ".json"
  end

  def data
    JSON.parse File.read(file_path)
  end

  def data_where(key,value)
    data.select{|i| i[key]==value }
  end

  def filtered_data
    fdata = data
    search_params.each do |search_key,search_value|
      fdata = fdata.select{|i| i[search_key]==search_value || i[search_key]==search_value.to_i }
    end
    return fdata
  end

end