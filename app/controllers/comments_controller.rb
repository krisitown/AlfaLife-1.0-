class CommentsController < ApplicationController
    def create
        login_check
        @comment = Comment.new(content: params[:content], user_id: session[:current_user],
            comment_id: params[:comment_id], question_id: params[:question_id], article_id: params[:article_id], points: 0)
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

    def upvote
        respond_to do |format|
            @cp = CommentsPoint.where(:comment_id => params[:comment_id], user_id: session[:current_user]).first
            if @cp != nil
                @cp.vote = 'up'
                @cp.save
            else
                @cp = CommentsPoint.new(user_id: session[:current_user], comment_id: params[:comment_id],
                    vote: 'up')
                @cp.save
            end
            points = CommentsPoint.where(:comment_id => params[:comment_id], :vote => 'up').size
            points -= CommentsPoint.where(:comment_id => params[:comment_id], :vote => 'down').size
            comment = Comment.find(params[:comment_id])
            comment.points = points
            comment.save
            format.js { render nothing: true }
        end
    end

    def downvote
        respond_to do |format|
            @cp = CommentsPoint.where(:comment_id => params[:comment_id], user_id: session[:current_user]).first
            if @cp != nil
                @cp.vote = 'down'
                @cp.save
            else
                @cp = CommentsPoint.new(user_id: session[:current_user], comment_id: params[:comment_id],
                    vote: 'down')
                @cp.save
            end
            points = CommentsPoint.where(:comment_id => params[:comment_id], :vote => 'up').size
            points -= CommentsPoint.where(:comment_id => params[:comment_id], :vote => 'down').size
            comment = Comment.find(params[:comment_id])
            comment.points = points
            comment.save
            format.js { render nothing: true }
        end
    end

    def delete
        admin_check
        @comment = Comment.find(params[:id]).destroy
        redirect_to questions_url
    end

    private
        def login_check
            if session[:current_user] == nil
                flash[:danger] = "Please log in to post a comment"
                redirect_to root_url
            end
        end

        def admin_check
            if User.find(session[:current_user]).is_admin == false
                redirect_to root_url
                flash[:danger] = "You do not have access to this part of the web app."
            end
        end
end
