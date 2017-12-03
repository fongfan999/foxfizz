module ApplicationHelper
  def oauth_path(provider)
    "/auth/#{provider}"
  end
end
