if Rails.env.development?
  
  Sidekiq.configure_server do |config|
    config.redis = { url: 'redis://localhost:6379/0' }
  end
  
  Sidekiq.configure_client do |config|
    config.redis = { url: 'redis://localhost:6379/0'}
  end
else
  Sidekiq.configure_server do |config|
    config.redis = { url: 'redis://rediscloud:vFez1P0zXQvtimonZsdzQHkPdHr1f67v@redis-10941.c11.us-east-1-2.ec2.cloud.redislabs.com:10941' }
  end
  
  Sidekiq.configure_client do |config|
    config.redis = { url: 'redis://rediscloud:vFez1P0zXQvtimonZsdzQHkPdHr1f67v@redis-10941.c11.us-east-1-2.ec2.cloud.redislabs.com:10941' }
  end
  
end
