class RegistrationsController < Devise::RegistrationsController
  # Overwrite update_resource to let users to update their user without giving their password

  def update_resource(resource, params)
    if ! current_user.provider.blank?
      params.delete("current_password")
      resource.update_without_password(params)
    else
      resource.update_with_password(params)
    end
  end

  private

  def sign_up_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :organization_id)
  end

  def account_update_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :current_password, :organization_id)
  end
end
