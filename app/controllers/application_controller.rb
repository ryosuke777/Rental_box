class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    case resource
    when Group
      '/public' # 顧客ログイン後、トップページへ飛ぶ
    when Admin
      '/admin/homes/top'
    end
  end

  def after_sign_out_path_for(resource)
    case resource
    when :group
      '/groups/sign_in'
    when :admin
      '/admins/sign_in'
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,
                                      keys: %i[email group_name group_name_kana representative_name representative_name_kana
                                               representative_telephone_number subdelegate_name subdelegate_name_kana subdelegate_telephone_number subdelegate_email])
  end
end
