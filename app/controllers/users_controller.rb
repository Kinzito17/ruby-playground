class UsersController <  ApplicationController
    before_action :set_user, only: [:edit, :update, :show]

    def show
        @articles = @user.articles
    end

    def new
    @user = User.new
    end

    def edit
    end

    def update
        if @user.update(user_params)
            flash[:notice] = "Your profile has been edited successfully"
            redirect_to articles_path
          else
            render :edit, status: 422      
        end
    end

    def create
        @user = User.new(user_params)
        if @user.save
            flash[:notice] = "Welcome #{@user.username}, your account has been created successfully"
            redirect_to articles_path
          else
            render :new, status: 422      
          end
    end

    private
    def user_params
        params.require(:user).permit(:username, :email, :password)
    end
  
    def set_user
        @user = User.find(params[:id])
    end
  
end