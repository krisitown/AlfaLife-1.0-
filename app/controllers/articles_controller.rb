class ArticlesController < ApplicationController
    def new
        @article = Article.new
    end

    def create
        @article = Article.new(article_params)
        if @article.save
            redirect_to @article
        else
            flash[:danger] = "An error occured while trying to add the article"
            redirect_to new_article_url
        end
    end

    def index
        @articles = Article.all
    end

    def show
        @article = Article.find(params[:id])
    end

    private
        def article_params
            params.require(:article).permit(:title, :thumbnail, :content, :user_id)
        end
end
