class ApplicationController < ActionController::Base
  protect_from_forgery

  protected
    def redirect_with_message(options = {})
      raise 'No :if is defined' unless options.has_key? :if

      if options[:if].call
        redirect_to root_path, notice: options[:notice]
      else
        redirect_to root_path, alert: options[:alert]
      end
    end
end
