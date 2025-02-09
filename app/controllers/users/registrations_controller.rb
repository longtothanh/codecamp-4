module Users
    class RegistrationsController < Devise::RegistrationsController
        before_action :configure_sign_up_params, only: [:create]
        before_action :configure_account_update_params, only: [:update]

        def update
            self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
            prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

            resource_updated = update_resource(resource, account_update_params)
            yield resource if block_given?
            if resource_updated
                set_flash_message_for_update(resource, prev_unconfirmed_email)
                bypass_sign_in resource, scope: resource_name if sign_in_after_change_password?

                sign_out current_user
                redirect_to new_user_session_path, notice: 'Profile updated successfully.'
            else
                clean_up_passwords resource
                set_minimum_password_length

                redirect_to edit_user_registration_path, alert: "Failed to update profile: #{resource.errors.full_messages.join(', ')}"
            end
        end

        protected

        def configure_sign_up_params
            devise_parameter_sanitizer.permit(:sign_up, keys: [:user_name])
        end

        def configure_account_update_params
            devise_parameter_sanitizer.permit(:account_update, keys: [:user_name])
        end

        def after_update_path_for(resource)
            users_information_path
        end

        private

        def account_update_params
            params.require(:user).permit(:email, :password, :password_confirmation, :current_password, :user_name)
        end
    end
end