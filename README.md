discourse-omniauth-gitlab
=========================

Discourse plugin for the omniauth-gitlab strategy.

## Installation

1. Register a new system application in GitLab by visiting `/admin/applications/new`.
    The redirect URI is of the form:

    ```
    https://discourse.example.com/auth/gitlab/callback
    ```

1. Add the plugin's repository url to your container's `app.yml` file:

    ```
    hooks:
      after_code:
        - exec:
            cd: $home/plugins
            cmd:
              - mkdir -p plugins
              - git clone https://github.com/discourse/docker_manager.git
              - git clone https://gitlab.com/gitlab-org/discourse-omniauth-gitlab.git
    ```

1. Rebuild the container by providing the APP_ID, SECRET and GitLab url values:

    ```
        cd /var/discourse
        git pull origin master
        GITLAB_APP_ID=gitlabtestid GITLAB_SECRET=gitlabtestsecret GITLAB_URL=https://git.example.com ./launcher rebuild app
    ```

    Otherwise you can add these variables in `app.yml` under the `env` section.

## License

MIT, see [LICENSE](./LICENSE).
