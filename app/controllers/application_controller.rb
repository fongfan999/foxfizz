class ApplicationController < ActionController::Base
  include SessionsHelper

  protect_from_forgery with: :exception
  before_action :authenticate_user!

  protected

  def authenticate_user!
    unless user_signed_in?
      store_user_location!
      redirect_to root_path, alert: I18n.t('sessions.failure.unauthenticated')
    end
  end
end
