module Authenticable

  def auth_current_user
    @auth_current_user ||= User.find_by(auth_token: request.headers['Authorization'])
  end

  def authenticate_with_token!
    render json: { errors: "Not Authenticateed"}, status: :unauthorized unless user_signed_in_with_token?
  end

  def user_signed_in_with_token?
    auth_current_user.present?
  end
end
