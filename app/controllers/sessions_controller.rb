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
            flash.now[:danger] = "Invalide email/password combination"
            render 'new'
        end
    end

    def destroy
        session[:current_user] = nil
        redirect_to root_url
    end
end