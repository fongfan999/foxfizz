class SessionsController < ApplicationController
  skip_before_action :authenticate_user!

  def create
    user = UserService.from_omniauth(request.env['omniauth.auth'])

    if user
      session[:user_id] = user.id
      flash[:notice] = I18n.t('sessions.signed_in')
    else
      flash[:alert] = I18n.t('sessions.failure.invalid')
    end

    redirect_to_previous_page(fallback_url: root_path)
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  private

  def redirect_to_previous_page(fallback_url:)
    if session[:forwarding_url]
      forwarding_url = session.delete(:forwarding_url)
      redirect_to forwarding_url
    else
      redirect_back(fallback_location: fallback_url)
    end
  end
end
