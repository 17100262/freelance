if Rails.env.development?
  
  Sidekiq.configure_server do |config|
    config.redis = { url: 'redis://localhost:6379/0' }
  end
  
  Sidekiq.configure_client do |config|
    config.redis = { url: 'redis://localhost:6379/0'}
  end
else
  Sidekiq.configure_server do |config|
    config.redis = { url: 'redis://rediscloud:jjnuE0ikA6MLm1bbw6UutZHpuYHgE1Ap@redis-10415.c16.us-east-1-3.ec2.cloud.redislabs.com:10415' }
  end
  
  Sidekiq.configure_client do |config|
    config.redis = { url: 'redis://rediscloud:jjnuE0ikA6MLm1bbw6UutZHpuYHgE1Ap@redis-10415.c16.us-east-1-3.ec2.cloud.redislabs.com:10415' }
  end
  
end
