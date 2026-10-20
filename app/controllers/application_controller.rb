class ApplicationController < ActionController::Base
  include Authentication
  include CurrentCart
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  def require_admin
    unless Current.user.has_role?(:admin)
      redirect_to root_path, alert: "Acess denied"
    end
  end
end
