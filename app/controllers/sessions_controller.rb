class SessionsController < ApplicationController
  def new
    # Render the login form
  end

  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      # Login successful
      session[:user_id] = user.id
      redirect_to root_path, notice: 'Logged in successfully!'
    else
      # Login failed
      flash.now[:alert] = 'Invalid email or password'
      render :new
    end
  end

  def destroy
    # Logout logic
    session[:user_id] = nil
    redirect_to root_path, notice: 'Logged out successfully!'
  end
end
