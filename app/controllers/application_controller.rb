class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  private

  def restrict_access
    unless restrict_access_by_params || restrict_access_by_header
      render json: { message: "Invalid Api Token" }, status: 401
      return
    end
  end

  def restrict_access_by_header
    return true if api_key
    authenticate_with_http_token do |token|
      @api_key = ApiKey.find_by_token(token)
    end
  end

  def restrict_access_by_params
    return true if api_key
    @api_key = ApiKey.find_by_token(params[:token])
  end

  def api_key
    @api_key
  end
end
