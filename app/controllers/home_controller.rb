class HomeController < ApplicationController
    protect_from_forgery except: [:webhook]
    skip_before_action :authenticate_user!
    def home
        
    end
    def jobs
        if params[:category].present? or params[:subcategory].present? or params[:search].present?
            if params[:search].present?
                @jobs = Job.search(params[:search])
            elsif params[:subcategory].present?
                subcategory = Subcategory.find_by_name(params[:subcategory])
                @jobs = Job.where(status: "LIVE",subcategory_id: subcategory.id).includes(:category).order('created_at DESC').paginate(:page => params[:page], :per_page => 5)
                @status = subcategory.category.name
            elsif params[:category].present?
                @jobs = Job.where(status: "LIVE",category_id: Category.find_by_name(params[:category]).id).includes(:category).order('created_at DESC').paginate(:page => params[:page], :per_page => 5)
                @status = params[:category]
            end
        else
            @jobs = Job.where(status: "LIVE").order('created_at DESC').includes(:category).paginate(:page => params[:page], :per_page => 5)
            @status = "alljobs"
        end
        @factor = Variable.find_by_name("RESERVATION_FACTOR").value.to_f
    end
    def profiles
       @user = User.find(params[:id]) 
    end
    
    def webhook
        if params["resource_type"] == "payouts_item"
            puts "RECEIVED"
            payout_batch_id = params["resource"]["payout_batch_id"]
            payout_id = params["resource"]["payout_item"]["sender_item_id"]
            status = params["event_type"].split(".").last.downcase.to_sym
            @statement = Statement.find_by(id: payout_id)
            p status
            @statement.update(status: status)
            
        end
        head :ok
    end
end
