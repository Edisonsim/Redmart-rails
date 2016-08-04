class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only:  :destroy

  def show
     @user = User.find(params[:id])
     @reviews = @user.reviews.paginate(page: params[:page])
   end

   def index
     @users = User.paginate(page: params[:page])
   end

   def new
      @user = User.new
   end

   def create
      @user = User.new(user_params) # Not the final implementation!
     if @user.save
       log_in @user
       flash[:success] = "Welcome to RedMart!"
       redirect_to @user
       # Handle a successful save.
     else
       render 'new'
     end
   end

   def edit
     @user = User.find(params[:id])
   end

   def update
     @user = User.find(params[:id])
      if @user.update_attributes(user_params)
      # Handle a succesful update.
      flash[:success] = "Profile updated"
     redirect_to @user
     else
       render 'edit'
     end
   end

   def destroy
       User.find(params[:id]).destroy
       flash[:success] = "User deleted"
       redirect_to users_url
     end

   private

    #confirms an admin user
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

     def user_params
       params.require(:user).permit(:name, :email, :password,
                                    :password_confirmation)
     end

     def logged_in_user
       unless logged_in?
         store_location
         flash[:danger] = "Please log in."
         redirect_to login_url
       end
     end
       # Confirms the correct user.
      def correct_user
        @user = User.find(params[:id])
        flash[:warning] = "You are not allowed to enter other people's page"
        redirect_to(root_url) unless current_user?(@user)
        end
      end
