function awsl([string]$SsoName) {
  aws sso login --sso-session ${SsoName}
}
