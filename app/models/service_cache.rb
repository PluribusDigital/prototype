class ServiceCache < ActiveRecord::Base

  def self.all_records
    ServiceCache.where(service:self.new.class.to_s)
  end

  def self.find(key)
    all_records.where(key:key)
  end

private

  def self.write_cache(key,data)
    cache = ServiceCache.find_or_initialize_by(service:self.new.class.to_s,key:key)
    cache.update(data:data)
  end

  
end
