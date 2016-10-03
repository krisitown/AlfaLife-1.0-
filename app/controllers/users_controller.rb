class UsersController < ApplicationController
    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            flash[:success] = "Successfully created account!"
            session[:current_user] = @user.id
            redirect_to root_url
        else 
            flash[:danger] = "An error occured while trying to create new account"
            render 'new'
        end
    end

    private
        def user_params
            params.require(:user).permit(:name, :email,
                :password, :password_confirmation)
        end
end
