unset __HM_SESS_VARS_SOURCED

for hm_session_vars in \
  "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh" \
  "$HOME/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh" \
  "/etc/profiles/per-user/$USER/etc/profile.d/hm-session-vars.sh"
do
  if [[ -r "$hm_session_vars" ]]; then
    source "$hm_session_vars"
    break
  fi
done

typeset -U path
path=($path)

unset hm_session_vars
