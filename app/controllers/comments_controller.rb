class CommentsController < ApplicationController
    def create
        #login_check
        @comment = Comment.new(content: params[:content], user_id: session[:current_user],
            comment_id: params[:comment_id], question_id: params[:question_id], article_id: params[:article_id])
        if @comment.save
            if params[:question_id] != nil
                redirect_to root_url + 'questions/' + params[:question_id]
            else
                redirect_to root_url + 'articles/' + params[:article_id]
            end
        else
            flash[:danger] = "An error occured while trying to submit a comment"
            redirect_to root_url + 'questions/' + params[:question_id]
        end
    end

    private
        def login_check
            if session[:current_user] == nil
                flash[:danger] = "Please log in to post a comment"
                redirect_to root_url
            end
        end
end
