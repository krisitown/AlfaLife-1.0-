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
            @user = User.find(session[:current_user])
            @user.payments -= 1
            @user.save
            redirect_to root_url
        else 
            flash[:danger] = "An error occured whilst trying to request plan, please check the information you sent and try again."
            render 'new'
        end
    end

    def index
        admin_check
        @plan_requests = PlanRequest.all().order(:created_at => :desc).paginate(:page => params[:page], :per_page => 5)
        @plan = Plan.new
    end

    def make_payment
        log_in_check
    end

    def send_payment
        log_in_check

        credit_card = ActiveMerchant::Billing::CreditCard.new(
            :first_name => params[:first_name],
            :last_name => params[:last_name],
            :number => params[:card_number],
            :month => params[:month],
            :year => params[:year],
            :verification_value => params[:verification_number]
        )

        if credit_card.valid?
            gateway = ActiveMerchant::Billing::PayflowGateway.new(
                :login => 'LOG_IN_ID',
                :password => 'PASSWORD'
            )
            response = gateway.purchase(1000, credit_card)
            if response.success?
                flash[:success] = "Payment was made, please wait for us to get back to you."
                @user = User.find(session[:current_user])
                @user.payments += 1
                @user.save
                redirect_to new_plan_request_path
            else
                flash[:danger] = "An error occured while trying to make the payment, you will not be charged. Please try again."
            end
        else
            flash[:danger] = "An error occured while trying to make the payment, you will not be charged. Please try again."
            credit_card.errors.each do |err|
                flash[:danger] += err.to_s
            end
        end
        redirect_to plans_url
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

        def payment_check
            if User.find(session[:current_user]).payments < 1
                flash[:danger] = "You need to make a payment, before accessing this page."
                redirect_to root_url + 'make_payment'
            end
        end
end