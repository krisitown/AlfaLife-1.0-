class PlansController < ApplicationController
    def new
        admin_check
        @request = PlanRequest.find(params[:request_id])
        @plan = Plan.new
    end

    def create
        admin_check
        @plan = Plan.new(read: false, to_user: params[:to_user], content: params[:plan][:content])
        if @plan.save
            flash[:success] = "You've successfully sent the plan."
            redirect_to plan_requests_path
        else
            flash[:danger] = "An error occured whilst trying to send the plan, please check the information you've inputted and try again"
            redirect_to plan_requests_path
        end
    end

    private
        def admin_check
            if User.find(session[:current_user]).is_admin == false
                redirect_to root_url
                flash[:danger] = "You do not have access to this part of the web app."
            end
        end
end
