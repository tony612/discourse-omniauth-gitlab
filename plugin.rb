# name:  discourse-omniauth-gitlab
# about: Authenticate Discourse with GitLab
# version: 0.0.1
# author: Achilleas Pipinellis

require 'omniauth2-gitlab'

class GitLabAuthenticator < ::Auth::Authenticator

  GITLAB_APP_ID = ENV['GITLAB_APP_ID']
  GITLAB_SECRET = ENV['GITLAB_SECRET']

  def name
    'gitlab'
  end

  def after_authenticate(auth_token)
    result = Auth::Result.new

    # Grap the info we need from OmniAuth
    data = auth_token[:info]
    name = data["first_name"]
    gl_uid = auth_token["uid"]
    email = data['email']

    # Plugin specific data storage
    current_info = ::PluginStore.get("gl", "gl_uid_#{gl_uid}")

    result.user =
      if current_info
        User.where(id: current_info[:user_id]).first
      end

    result.name = name
    result.extra_data = { gl_uid: gl_uid }
    result.email = email

    result
  end

  def after_create_account(user, auth)
    data = auth[:extra_data]
    ::PluginStore.set("gl", "gl_uid_#{data[:gl_uid]}", {user_id: user.id })
  end

  def register_middleware(omniauth)
    omniauth.provider :gitlab,
     GITLAB_APP_ID,
     GITLAB_SECRET,
     { client_options: {site: ENV['GITLAB_SITE_URL'], }}
  end
end


auth_provider :title => 'with GitLab',
    :message => 'Log in via GitLab (Make sure pop up blockers are not enabled).',
    :frame_width => 920,
    :frame_height => 800,
    :authenticator => GitLabAuthenticator.new


# We ship with zocial, it may have an icon you like http://zocial.smcllns.com/sample.html
#  In our current case we don't have an icon for GitLab
register_css <<CSS

.btn-social.gitlab {
  background: #554488;
}

.btn-social.gitlab:before {
  content: "G";
}

CSS