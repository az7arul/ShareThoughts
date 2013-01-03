class ApplicationController < ActionController::Base
  protect_from_forgery


  protected

    def ensure_admin!
      redirect_to root_path unless current_user.is_admin?
    end

    def redirect_with_message(options = {})
      raise 'No :if is defined' unless options.has_key? :if

      if options[:if].call
        redirect_to root_path, notice: options[:notice]
      else
        redirect_to root_path, alert: options[:alert]
      end
    end
end
