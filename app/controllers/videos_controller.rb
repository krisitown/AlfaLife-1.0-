class VideosController < ApplicationController
    def new
        log_in_check
        @video = Video.new
    end

    def create 
        log_in_check
        @video = Video.new(title: params[:title], link: params[:link], user_id: session[:current_user], views: 0)
        @video.video_id = /^.*(youtu\.be\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*/.match(@video.link)[2]
        @video.thumbnail = "https://img.youtube.com/vi/" + @video.video_id + "/default.jpg"
        if @video.save
            flash[:success] = "Video added successfully"
            redirect_to videos_path
        else 
            flash[:danger] = "An error occured, please check the information given and try again"
            redirect_to new_video_path
        end
    end

    def show
        @video = Video.find(params[:id])
        @video.views += 1
        @video.save
        
    end

    def index
        if params[:category] == "new"
            @videos = Video.all.order(:created_at => :desc).paginate(:page => params[:page], :per_page => 9)
        elsif params[:category] == "most_viewed"
            @videos = Video.all.order(:views => :desc).paginate(:page => params[:page], :per_page => 9)
        elsif params[:category] == "featured"
            @videos = Video.where(:featured => true).paginate(:page => params[:page], :per_page => 9)
        else 
            @videos = Video.where(["created_at > ?", 2.day.ago]).order(:views => :desc).paginate(:page => params[:page], :per_page => 9)
        end
    end

    def delete
        admin_check
        @video = Video.find(params[:id]).destroy
        redirect_to questions_url
    end

    def make_featured
        admin_check
        @video = Video.find(params[:id])
        @video.featured = true
        @video.save
        redirect_to videos_path
    end

    private
        def log_in_check
            if session[:current_user] == nil
                flash[:danger] = "Please log in to access this page."
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
