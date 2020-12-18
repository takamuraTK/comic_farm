
module Overrides
  class ConfirmationsController < DeviseTokenAuth::ConfirmationsController
    def show
      @resource = resource_class.confirm_by_token(resource_params[:confirmation_token])

      if @resource.errors.empty?
        render json: {
          success: true,
          data: @resource.as_json()
        }
      else
        render json: {
          success: false,
          errors: ["Invalid login credentials"]
        }, status: 401
      end
    end

    def create
      return render_create_error_missing_email if resource_params[:email].blank?

      @email = get_case_insensitive_field_from_resource_params(:email)

      @resource = resource_class.dta_find_by(uid: @email, provider: provider)

      return render_not_found_error unless @resource

      @resource.send_confirmation_instructions({
        redirect_url: redirect_url,
        client_config: resource_params[:config_name]
      })

      return render_create_success
    end

    protected

    def render_create_error_missing_email
      render_error(401, I18n.t('devise_token_auth.confirmations.missing_email'))
    end

    def render_create_success
      render json: {
          success: true,
          message: I18n.t('devise_token_auth.confirmations.sended', email: @email)
      }
    end

    def render_not_found_error
      render_error(404, I18n.t('devise_token_auth.confirmations.user_not_found', email: @email))
    end

    private

    def resource_params
      params.permit(:email, :confirmation_token, :config_name)
    end

    # give redirect value from params priority or fall back to default value if provided
    def redirect_url
      params.fetch(
        :redirect_url,
        DeviseTokenAuth.default_confirm_success_url
      )
    end
  end
end
