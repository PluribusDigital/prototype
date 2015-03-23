class JsonApiController < ApplicationController

  def index
    # keys off of resource_name from route param
    # /json_api/:resource_name
    # to find a matching file in 
    # data/json_api/[resource_name].json
    # any additional url params are used to filter the dataset
    # /json_api/:resource_name?key=value&
    @data = JsonApi.new(params).filtered_data
    render :json => @data
  end

end