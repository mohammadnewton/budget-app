class UsersController < ApplicationController
  def new
    # Render the signup form
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      # Signup successful
      session[:user_id] = @user.id
      redirect_to root_path, notice: 'Account created successfully!'
    else
      # Signup failed
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
