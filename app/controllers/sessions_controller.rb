class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by({"email" => params["email"]})
    if @user
      password_the_user_typed = params["password"]
      password_in_the_database = @user["password"]
      if BCrypt::Password.new(password_in_the_database) == password_the_user_typed
        session["user_id"] = @user["id"]
        redirect_to "/places"
      else
        redirect_to "/login"
      end
    else
        redirect_to "/login"
    end
  end

  def destroy
    session["user_id"] = nil
    redirect_to "/sessions/new"
  end
end
  