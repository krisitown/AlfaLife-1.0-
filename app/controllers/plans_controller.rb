class PlansController < ApplicationController
    def new
        log_in_check
        admin_check
        @request = PlanRequest.find(params[:request_id])
        @plan = Plan.new
    end

    def create
        log_in_check
        admin_check
        @plan = Plan.new(read: false, to_user: params[:to_user], title: params[:plan][:title], content: params[:plan][:content])
        if @plan.save
            messages = Message.new(title: "You have received a plan!",
                    content: "You can view the plan " + '<a href=' +  root_url + 'plans/' + @plan.id.to_s + '>here</a>',
                    to_id: params[:to_user], read: false)
            flash[:success] = "You've successfully sent the plan."
            redirect_to plan_requests_path
        else
            flash[:danger] = "An error occured whilst trying to send the plan, please check the information you've inputted and try again."
            redirect_to plan_requests_path
        end
    end

    def show
        @plan = Plan.find(params[:id])
        if @plan.to_user != session[:current_user]
            flash[:danger] = "You do not have access to this part of the website. If you aren't logged in please do so."
            redirect_to root_url
        end
    end

    def index
        log_in_check
        @plans = Plan.where(:to_user => session[:current_user])
        @plans.update_all(:read => true)
        @plans = @plans.paginate(:page => params[:page], :per_page => 5)
    end

    private
        def log_in_check
            if session[:current_user] == nil
                flash[:danger] = "Please log in to enter this page."
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
