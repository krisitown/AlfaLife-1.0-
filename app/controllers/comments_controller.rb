class CommentsController < ApplicationController
    def create
        login_check
        @comment = Comment.new(content: params[:content], user_id: session[:current_user],
            comment_id: params[:comment_id], question_id: params[:question_id], article_id: params[:article_id], points: 0)
        if @comment.save
            if params[:question_id] != nil
                @message = Message.new(title: User.find(session[:current_user]).name + " has replied to your question!",
                    content: "You can view the reply " + '<a href=' +  root_url + 'questions/' + params[:question_id] + '>here</a>',
                    to_id: question_owner(), read: false)
                @message.save
                redirect_to root_url + 'questions/' + params[:question_id]
            elsif params[:comment_id] != nil && find_origin_question() != nil
                @message = Message.new(title: User.find(session[:current_user]).name + " has replied to your comment!",
                    content: "You can view the reply " + '<a href=' +  root_url + 'questions/' + find_origin_question().id.to_s + '>here</a>' +
                    " </br> \"" + @comment.content + "\" ",
                    to_id: comment_owner, read: false)
                @message.save

                redirect_to root_url + 'questions/' + find_origin_question().id.to_s
            else
                redirect_to root_url + 'articles/' + find_origin_article().id.to_s
            end
        else
            flash[:danger] = "An error occured while trying to submit a comment"
            redirect_to(:back)
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
            calc_points_for(Comment.find(params[:comment_id]).user_id)
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
            calc_points_for(Comment.find(params[:comment_id]).user_id)
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

        def question_owner
            User.find(Question.find(params[:question_id]).user_id).id
        end

        def comment_owner
            User.find(Comment.find(params[:comment_id]).user_id).id
        end

        def find_origin_article
            comment = Comment.find(params[:comment_id])
            while comment.question_id == nil && comment.article_id == nil do
                origin_comment = Comment.find(comment.comment_id)
                if origin_comment.question_id != nil
                    comment = origin_comment
                    break
                else
                    comment = origin_comment
                end
            end
            if origin_comment.article_id != nil
                Article.find(origin_comment.article_id)
            elsif comment.article_id != nil
                Article.find(comment.article_id)
            end
        end

        def find_origin_question
            comment = Comment.find(params[:comment_id])
            while comment.question_id == nil && comment.article_id == nil do
                origin_comment = Comment.find(comment.comment_id)
                if origin_comment.question_id != nil
                    comment = origin_comment
                    break
                else
                    comment = origin_comment
                end
            end
            if origin_comment != nil && origin_comment.question_id != nil
                Question.find(origin_comment.question_id)
            elsif comment != nil && comment.question_id != nil
                Question.find(comment.question_id)
            end
        end

        def calc_points_for(user_id)
            user = User.find(user_id)
            points = 0
            Comment.where(user_id).each do |comment|
                points += comment.points
            end
            user.points = points
            user.save
        end
end
