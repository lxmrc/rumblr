class RegistrationsController < Devise::RegistrationsController
  def update
    super
    resource.update(slug: resource.username)
  end

  def destroy
    resource.soft_delete
    Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
    set_flash_message :notice, :destroyed
    yield resource if block_given?
    respond_with_navigational(resource){ redirect_to after_sign_out_path_for(resource_name) }
  end

  protected
  
  def after_sign_up_path_for(user)
    edit_user_registration_path
  end

  def after_update_path_for(user)
    user_path(user.username)
  end

  def update_resource(resource, params)
    return super if params["password"]&.present?
    resource.update_without_password(params.except("current_password"))
  end
end
