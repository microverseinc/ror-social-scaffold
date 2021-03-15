module LayoutsHelper
  def sign_out_or_in
    if current_user
      render 'layouts/sign_out'
    else
      render 'layouts/sign_in'
    end
  end

  def notice_or_alert
    render 'layouts/show_notice' if notice.present?
    render 'layouts/show_alert' if alert.present?
  end
end
