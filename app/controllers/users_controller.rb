class UsersController < ApplicationController
    before_action :authenticate_user!, except: [:complete_sign_up,:completed_sign_up]
    skip_before_action :check_paypal_email, only: [:edit, :update]
    def edit
        @user = User.find(params[:id])
    end
    
    def update
        @user = User.find(params[:id])
        if @user.update(user_params)
            redirect_to user_panel_path, notice: "User profile updated successfully"
        else
            redirect_to edit_user_path, notice: @user.errors.full_messages.join
        end
    end
    
    def complete_sign_up
        # byebug
        @user = User.new(uid: session['devise.google_data']['uid'], provider: session['devise.google_data']['provider'], name: session['devise.google_data']['info']['name'], email: session['devise.google_data']['info']['email']  )
        # byebug
        @user.password = Devise.friendly_token[0,20]
        @user.validate
        
    end
    
    def completed_sign_up
        @user = User.new(user_params)
        data = session['devise.google_data'] || session['devise.facebook_data'] || session['devise.linkedin_data'] || session['devise.twitter_data']
        @user.uid = data['uid']
        @user.provider = data['provider']
        @user.name = data['info']['name']
        @user.password = Devise.friendly_token[0,20]
        @user.skip_confirmation!
        
        if @user.save
            sign_in_and_redirect @user, event: :authentication
        else
            render :complete_sign_up
        end
        
    end
    
    private
    def user_params
        params.require(:user).permit(:email,:uid,:provider,:name, :username,:phone_number,:identifier,:company_name,:linkedin_link,:githhub_link,:website_link,:portfolio,:other_link1,:other_link2,:other_link3,:experience, :paypal_email)
    end
end
