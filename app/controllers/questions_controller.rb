class QuestionsController < ApplicationController
    def new
        check_user
        @question = Question.new
    end

    def create
        check_user
        @question = Question.new(title: params[:question][:title], 
            content: params[:question][:content], category: params[:category], user_id: session[:current_user])
        if @question.save
            flash[:success] = "Question successfully added."
            redirect_to questions_url
        else
            flash[:danger] = "An error occured whilst trying to add your question please try again."
            render 'new'
        end
    end

    def index
        @questions = Question.order(:created_at => :desc).paginate(:page => params[:page], :per_page => 10)
    end

    def delete
        admin_check
        @question = Question.find(params[:id]).destroy
        redirect_to questions_url
    end

    def show
        @question = Question.find(params[:id])
        @comments = Comment.where(:question_id => params[:id]).order("points DESC, created_at DESC").paginate(:page => params[:page], :per_page => 5)
    end
    
    def change_category
        category = params[:category]
        if category == "all"
            @questions = Question.order(:created_at => :desc).paginate(:page => params[:page], :per_page => 10)
        else
            @questions = Question.where(:category => category).order("created_at DESC").paginate(:page => params[:page], :per_page => 10)
        end
        @current_category = category
        render 'index'
    end

    private
        def check_user
            if session[:current_user] == nil
                flash[:danger] = "Please log in, or create an account, in order to post a question."
                redirect_to root_url + '/login'
            end
        end

        def admin_check
            if User.find(session[:current_user]).is_admin == false
                redirect_to root_url
                flash[:danger] = "You do not have access to this part of the web app."
            end
        end
                
end
