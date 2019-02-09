class ApplicationController < ActionController::Base
    before_action :set_locale, :authenticate_user!
    def set_locale
        I18n.locale = params[:locale] || I18n.default_locale
    end
    
    def default_url_options
        { locale: I18n.locale }
    end

    # deviseコントローラーにストロングパラメータを追加     
    before_action :configure_permitted_parameters, if: :devise_controller?
  
    protected
    def configure_permitted_parameters
        added_attrs = [:name, :avatar]
        # サインアップ時のストロングパラメータ
        devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
        # アカウント編集時のストロングパラメータ
        devise_parameter_sanitizer.permit :account_update, keys: added_attrs
    end
end
