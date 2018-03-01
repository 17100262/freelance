class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, kind: "Facebook") if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      render "/users/complete_sign_up"
      # redirect_to new_user_registration_url, notice: @user.errors.full_messages.join(",")
    end
  end

  def failure
    redirect_to root_path
  end
  
  
  def linkedin
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, kind: "LinkedIn") if is_navigational_format?
    else
      session["devise.linkedin_data"] = request.env["omniauth.auth"]
      # redirect_to new_user_registration_url, notice: @user.errors.full_messages.join(",")
      render "/users/complete_sign_up"
    end
      
  end
  
  def google_oauth2
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, kind: "Google") if is_navigational_format?
    else
      session["devise.google_data"] = request.env["omniauth.auth"].except("extra")
      # byebug
      # redirect_to new_user_registration_url, notice: @user.errors.full_messages.join(",")
      render "/users/complete_sign_up"
      
      # redirect_to controller: '/users',action: 'complete_sign_up', param1: @user
    end
    
  end
  
  def twitter
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, kind: "Twitter") if is_navigational_format?
    else
      session["devise.twitter_data"] = request.env["omniauth.auth"].except("extra")
      # redirect_to complete_sign_up_users_path(@user), notice: @user.errors.full_messages.join(",")
      render "/users/complete_sign_up"
    end
    
  end
end