class MessagesController < ApplicationController
    def new
        @message = Message.new
    end

    def create
        @message = Message.new(title: params[:title], content: params[:content], from_id: session[:current_user], to_id: params[:to_id], read: false)
        if @message.save
            flash[:success] = "Successfully sent message." 
            redirect_to root_url
        else
            flash[:danger] = "An error occured whilst trying to send message, please check the information you inputted."
            redirect_to root_url
        end
    end

    def index 
        @messages = Message.where(:to_id => session[:current_user]).order(:created_at => :desc)
        @messages.update_all(:read => true)
        @messages = @messages.paginate(:page => params[:page], :per_page => 5)
    end
end
