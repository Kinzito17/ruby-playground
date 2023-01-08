class SessionsController <  ApplicationController

def new
end

def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
        session[:user_id] = user.id
        flash[:notice] = "You have logged in successfully"
        redirect_to user
    else
        flash.now[:alert] = "There was an issue with your login credentials"
        render :new, status: 422   
    end
end

def destroy
    session[:user_id] = nil
    flash[:notice] = "Logged out"
    redirect_to root_path
end

end
