class ArticlesController < ApplicationController
    def new
        @article = Article.new
    end

    def create
        admin_check
        @article = Article.new(article_params)
        if @article.save
            redirect_to @article
        else
            flash[:danger] = "An error occured while trying to add the article"
            redirect_to new_article_url
        end
    end

    def index
        @articles = Article.paginate(:page => params[:page], :per_page => 5)
    end

    def show
        @article = Article.find(params[:id])
    end

    def delete
        admin_check
        @article = Article.find(params[:id]).destroy
        redirect_to root_url
    end

    private
        def article_params
            params.require(:article).permit(:title, :thumbnail, :content, :user_id)
        end

        def admin_check
            if User.find(session[:current_user]).is_admin == false
                redirect_to root_url
                flash[:danger] = "You do not have access to this part of the web app."
            end
        end
end
