class HomeController < ApplicationController
    before_action :authenticate_user!
    def home
    end
    def jobs
       @jobs = Job.where(status: "LIVE").order('created_at ASC')
    end
    
end
