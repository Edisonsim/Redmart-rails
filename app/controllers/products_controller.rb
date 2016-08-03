class ProductsController < ApplicationController
    before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
    before_action :correct_user,   only: [:edit, :update]
    before_action :admin_user,     only:  :destroy

    def show
       @product = Product.find(params[:id])
     end

     def index
       @products = Product.paginate(page: params[:page])
     end

     def new
        @product = Product.new
     end

     def create
        @product = Product.new(user_params) # Not the final implementation!
       if @product.save
         log_in @product
         redirect_to @product
         # Handle a successful save.
       else
         render 'new'
       end
     end

     def edit
       @product = Product.find(params[:id])
     end

     def update
       @product = Product.find(params[:id])
        if @product.update_attributes(user_params)
        # Handle a succesful update.
        flash[:success] = "Product updated"
       redirect_to @product
       else
         render 'edit'
       end
     end

     def destroy
         Product.find(params[:id]).destroy
         flash[:success] = "Product deleted"
         redirect_to users_url
       end

     private

      #confirms an admin product
      def admin_user
        redirect_to(root_url) unless current_user.admin?
      end

       def user_params
         params.require(:product).permit(:name, :email, :password,
                                      :password_confirmation)
       end

       def logged_in_user
         unless logged_in?
           store_location
           flash[:danger] = "Please log in."
           redirect_to login_url
         end
       end
         # Confirms the correct product.
        def correct_user
          @product = Product.find(params[:id])
          flash[:warning] = "You are not allowed to enter other people's page"
          redirect_to(root_url) unless current_user?(@product)
          end
        end
