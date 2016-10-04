class QuestionsController < ApplicationController
    def new
        @question = Question.new
    end

    def create
        @question = Question.new(title: params[:question][:title], 
            content: params[:question][:content], user_id: session[:current_user])
        if @question.save
            flash[:success] = "Question successfully added."
            redirect_to questions_url
        else
            flash[:danger] = "An error occured whilst trying to add your question please try again"
            redirect_to new_question_url
        end
    end

    def index
        @questions = Question.all
    end

    def show
        @question = Question.find(params[:id])
    end
end
