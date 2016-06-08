class SponsoredPostsController < ApplicationController

  before_action :require_sign_in, except: :show
  before_action :authorize_user, except: [:show, :new, :create]


  def show
     @sponsoredpost = SponsoredPost.find(params[:id])
  end

  def new
   @topic = Topic.find(params[:topic_id])
   @sponsoredpost = SponsoredPost.new
  end

  def create
    @topic = Topic.find(params[:topic_id])
    @sponsoredpost = @topic.SponsoredPosts.build(sponsoredpost_params)
    @sponsoredpost.user = current_user
# #10
    if @sponsoredpost.save
      @sponsoredpost.labels = Label.update_labels(params[:sponsoredpost][:labels])
      flash[:notice] = "Sponsored post was saved successfully."
      redirect_to [@topic, @sponsoredpost]
    else
# #12
      flash.now[:alert] = "There was an error saving the sponsored post. Please try again."
      render :new
    end
  end


  def edit
      @sponsoredpost = SponsoredPost.find(params[:id])
  end

  def update
    @sponsoredpost = SponsoredPost.find(params[:id])
    @sponsoredpost.assign_attributes(sponsoredpost_params)


    if @sponsoredpost.save
      @sponsoredpost.labels = Label.update_labels(params[:sponsoredpost][:labels])
      flash[:notice] = "Sponsored post was updated successfully."
      redirect_to [@sponsoredpost.topic, @sponsoredpost]
    else
      flash.now[:alert] = "There was an error saving the sponsored post. Please try again."
      render :edit
    end
  end


   def destroy
     @sponsoredpost = SponsoredPost.find(params[:id])

 # #8
     if @sponsoredpost.destroy
       flash[:notice] = "\"#{@sponsoredpost.title}\" was deleted successfully."
       redirect_to @sponsoredpost.topic
     else
       flash.now[:alert] = "There was an error deleting the sponsored post."
       render :show
     end
   end

   private

   def sponsoredpost_params
     params.require(:sponsoredpost).permit(:title, :body, :price)
   end

   def authorize_user
     sponsoredpost = SponsoredPost.find(params[:id])
 # #11
     unless current_user == sponsoredpost.user || current_user.admin?
       flash[:alert] = "You must be an admin to do that."
       redirect_to [sponsoredpost.topic, sponsoredpost]
     end
   end

end
