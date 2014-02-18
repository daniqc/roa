class ApplicationController < ActionController::Base
  protect_from_forgery

  def help_methodologies
    option = params[:option]
    case option
      when "2" # Metodologia AODDIE
        render 'dashboard/aoddei_methodology'
      when "3" # Metodologia MIDOA
        render 'dashboard/midoa_methodology'
      when "4" # Metodologia ISD-MeLo
        render 'dashboard/isdmelo_methodology'
      else # indice de metodologias
        render 'dashboard/help_methodologies'
    end    
  end

  def aoddei
    option = params[:option]
    case option
      when "1" # Fase 1
        render 'dashboard/aoddei_methodology_phase1'
      when "2" # Fase 2
        render 'dashboard/aoddei_methodology_phase2'
      when "3" # Fase 3
        render 'dashboard/aoddei_methodology_phase3'
      when "4" # Fase 4
        render 'dashboard/aoddei_methodology_phase4'
      when "5" # Fase 5
        render 'dashboard/aoddei_methodology_phase5'
      else # indice de metodologias
        render 'dashboard/help_methodologies'
    end 
    
  end

  private

  def current_user
  	@current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def current_person
    @current_person ||= current_user.person if current_user
  end
  helper_method :current_person


  def authorize
  	redirect_to login_url, alert: "Not authorized" if current_user.nil?  	
  end

  
end
