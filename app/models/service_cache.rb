class ServiceCache < ActiveRecord::Base

  def self.find(key)
    ServiceCache.where(service:self.new.class.to_s, key:key).first.data
  end

private

  def self.write_cache(key,data)
    cache = ServiceCache.find_or_initialize_by(service:self.new.class.to_s,key:key)
    cache.update(data:data)
  end
  
end
