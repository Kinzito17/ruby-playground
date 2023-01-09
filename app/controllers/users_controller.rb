class UsersController <  ApplicationController
    before_action :set_user, only: [:edit, :update, :show, :destroy]
    before_action :require_user, except: [:show, :index, :new, :create]
    before_action :require_same_user, only: [:edit, :update, :destroy]
  
    def show
        @articles = @user.articles
    end

    def index
        @users = User.paginate(page: params[:page], per_page: 5)
    end

    def new
    @user = User.new
    end

    def edit
    end

    def update
        if @user.update(user_params)
            flash[:notice] = "Your profile has been edited successfully"
            redirect_to @user
          else
            render :edit, status: 422      
        end
    end

    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            flash[:notice] = "Welcome #{@user.username}, your account has been created successfully"
            redirect_to articles_path
          else
            render :new, status: 422      
          end
    end

    def destroy
        @user.destroy
        session[:user_id] = nil if @user == current_user
        flash[:notice] = "Account and articles have been deleted"
        redirect_to root_path
    end

    private
    def user_params
        params.require(:user).permit(:username, :email, :password)
    end
  
    def set_user
        @user = User.find(params[:id])
    end

    def require_same_user
        if current_user != @user && !current_user.admin?
          flash[:alert] = "You can only edit or delete your own profile"
          redirect_to root_path
        end
      end
  
  
end