class SessionsController < ApplicationController
    def new
    end

    def create
        user = User.find_by(email: params[:email].downcase)
        if user != nil && user.authenticate(params[:password])
            session[:current_user] = user.id
            flash[:success] = "Successfully logged in."
            redirect_to root_url
        else
            flash.now[:danger] = "Invalid email/password combination"
            render 'new'
        end
    end

    def social_auth
        auth_hash = request.env['omniauth.auth']
        @user = User.find_by(:email => auth_hash[:info][:email])
        if @user != nil && @user.authenticate(auth_hash[:uid])
            session[:current_user] = @user.id
            flash[:success] = "Successfully logged in."
            redirect_to root_url
        elsif @user == nil
            @user = User.new(email: auth_hash[:info][:email], name: auth_hash[:info][:name], password: auth_hash[:uid], password_confirmation: auth_hash[:uid])
            if @user.save
                session[:current_user] = @user.id
                flash[:success] = "Successfully logged in."
                redirect_to root_url
            else
                flash[:danger] = "An error occured while trying to log you in, please try again.(1)"
                redirect_to root_url + '/login'
            end
        else
            flash[:danger] = "An error occured while trying to log you in, please try again."
            redirect_to root_url + '/login'
        end    
    end

    def destroy
        session[:current_user] = nil
        redirect_to root_url
    end
end