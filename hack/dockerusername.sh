docker-credential-$(
  jq -r .credsStore ~/.docker/config.json
) list | jq -r '
  . |
    to_entries[] |
    select(
      .key |
      contains("docker.io")
    ) |
    last(.value)
'
