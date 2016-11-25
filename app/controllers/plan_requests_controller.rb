class PlanRequestsController < ApplicationController

    def new
        log_in_check
        @plan_request = PlanRequest.new
    end

    def create
        log_in_check
        @plan_request = PlanRequest.new(plan_params)
        if @plan_request.save
            flash[:success] = "Successfully sent plan request."
            redirect_to root_url
        else 
            flash[:danger] = "An error occured whilst trying to request plan, please check the information you sent and try again."
            render 'new'
        end
    end

    def index
        admin_check
        @plan_requests = PlanRequest.all().order(:created_at => :desc).paginate(:page => params[:page], :per_page => 5)
    end

    private
        def plan_params
            params.require(:plan_request).permit(:gender, :age, :weight, :height, :comments, :want_to, :unit, :user_id)
        end

        def log_in_check
            if session[:current_user] == nil
                flash[:danger] = "Please log in to continue."
                redirect_to root_url + 'login'
            end
        end

        def admin_check
            if User.find(session[:current_user]).is_admin == false
                redirect_to root_url
                flash[:danger] = "You do not have access to this part of the web app."
            end
        end
end