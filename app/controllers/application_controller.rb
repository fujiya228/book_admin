class ApplicationController < ActionController::Base
  before_action :detect_mobile_variant
  protect_from_forgery with: :exception

  private
  def detect_mobile_variant
    request.variant = :mobile if request.user_agent =~ /iPhone/
  end
end
