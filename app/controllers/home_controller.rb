class HomeController < ApplicationController
    skip_before_action :authenticate_user!
    def home
    end
    def jobs
        if params[:category].present?
            @jobs = Job.where(status: "LIVE",category_id: Category.find_by_name(params[:category]).id).includes(:category).order('created_at DESC')
            @status = params[:category]
        else
            @jobs = Job.where(status: "LIVE").order('created_at DESC').includes(:category)
            @status = "alljobs"
        end
    end
    def profiles
       @user = User.find(params[:id]) 
    end
    
end
