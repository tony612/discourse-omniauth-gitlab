discourse-omniauth-gitlab
=========================

Discourse plugin for the omniauth-gitlab strategy.

## Installation

1. Register a new system application in GitLab by visiting `/admin/applications/new`.
    The redirect URI is of the form:

    ```
    https://discourse.example.com/auth/gitlab/callback
    ```

1. Add the plugin's repository url to your container's `app.yml` file along with
   the other plugins:

    ```
    hooks:
      after_code:
        - exec:
            cd: $home/plugins
            cmd:
              - mkdir -p plugins
              - git clone https://gitlab.com/gitlab-org/discourse-omniauth-gitlab.git
    ```

1. Rebuild the container by providing the APP_ID, SECRET and GitLab url values:

    ```
    chmod 600 /var/discourse/containers/app.yml
    ```

    Add these variables in `/var/discourse/containers/app.yml` under the `env` section:

    ```
    ## GitLab OmniAuth settings
    GITLAB_APP_ID: gitlab_app_id
    GITLAB_SECRET: gitlab_secret
    GITLAB_URL: https://gitlab.example.com
    ```

    Now rebuild the app:

    ```
    cd /var/discourse
    git pull origin master
    ./launcher rebuild app
    ```

## License

MIT, see [LICENSE](./LICENSE).
