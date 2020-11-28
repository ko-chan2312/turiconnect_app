class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    
    before_action :configure_permitted_parameters, if: :devise_controller?

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:name]) 
      end

      private
       def posts_search_params
         params.require(:q).permit(:fish_or_content_cont)
       end

end
