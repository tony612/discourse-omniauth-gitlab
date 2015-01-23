discourse-omniauth-gitlab
=========================

Discourse plugin for the omniauth-gitlab strategy.

## Installation

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

1. Rebuild the container by providing the ID and SECRET values:

    ```
        cd /var/discourse
        git pull origin master
        GITLAB_APP_ID=gitlabtestid GITLAB_SECRET=gitlabtestsecret GITLAB_SITE_URL=https://git.example.com ./launcher rebuild app
    ```

    Otherwise you can provide these variables in `app.yml` under the `env` section.

## License

MIT, see [LICENSE](./LICENSE).
