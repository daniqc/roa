class SessionsController < ApplicationController
  layout "authentication"

  def new
  end

  def create
  	user = User.find_by_username(params[:username])
  	if user && user.authenticate(params[:password])
  		session[:user_id] = user.id
  		redirect_to root_url, notice: "Registrado!"
  	else
  		flash.now.alert = "El nombre de usuario o password es incorrecto!"
  		render "new"
  	end
  end

  def destroy
  	session[:user_id] = nil
  	redirect_to root_url, notice: "Logged out!"  	
  end
end
