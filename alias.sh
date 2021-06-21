#!/usr/bin/env bash

_guix_vars(){
    if [ -z "${GUIX_PREV_ENV}" ]; then
        export GUIX_PREV_ENV=("$(env)")
    fi
    if [ -z "${GUIX_MANIFEST_DIR}" ]; then
        export GUIX_MANIFEST_DIR="${XDG_CONFIG_DIR:-$HOME/.config}/guix-manifests"
    fi
    if [ -z "${GUIX_EXTRA_PROFILES}" ]; then
        export GUIX_EXTRA_PROFILES="${XDG_DATA_HOME:-$HOME/.local/share}/guix-extra-profiles"
    fi
    if [ -z "${GUIX_ACTIVE_MANIFESTS+x}" ]; then
        export GUIX_ACTIVE_MANIFESTS=()
    fi
    if [ -z "${GUIX_LOCPATH}" ]; then
        export GUIX_LOCPATH="${HOME}/.guix-profile/lib/locale"
    fi
}
_guix_list_manifests(){
    printf "The following manifests are available:\ndefault\n"
    for manifest in "${GUIX_MANIFEST_DIR}"/*.scm; do
        if [ "${manifest}" != "${GUIX_MANIFEST_DIR}/*.scm" ]; then # no glob
            printf '%s' "$(basename "${manifest%.*}")"
        fi
    done
}
_guix_install_profile(){
    local arg="${1}"
    local profile="${GUIX_EXTRA_PROFILES}/${arg}/${arg}"
    if [ "${arg}" != "default" ] &&
       [ ! -d "${profile}" ] &&
       [ -f "${GUIX_MANIFEST_DIR}/${arg}.scm" ]; then
        mkdir -p "${GUIX_EXTRA_PROFILES}/${arg}"
        guix package -m "${GUIX_MANIFEST_DIR}/${arg}.scm" -p "${profile}"
    fi
}
_guix_update_profile(){
    local arg="${1}"
    local profile="${GUIX_EXTRA_PROFILES}/${arg}/${arg}"
    if [ "${arg}" = "default" ];then
        guix pull
        guix package -u
    elif [ -f "${GUIX_MANIFEST_DIR}/${arg}.scm" ] &&
         [ -d "${profile}" ]; then
         guix package -m "${GUIX_MANIFEST_DIR}/${arg}.scm" -p "${profile}"
    else
        _guix_install_profile "${arg}"
    fi
}
_guix_deactivate_profile(){
    local arg="${1}"
    local ref="GUIX_PREV_ENV_${arg}"
    if [ -n "${!ref}" ]; then # the prev env exists # TODO: indirect variable expansion portable
        for entry in "${!ref[@]}"; do # unset vars of profile # TODO: indirect variable expansion portable
            if [[ ! "${entry%%=*}" =~ GUIX_PREV_ENV.* ]] &&
               [ "${entry%%=*}" != "GUIX_ACTIVE_MANIFESTS" ] ;then
                unset "${entry%%=*}"
            fi
        done
        unset "GUIX_PREV_ENV_${arg}"
        for entry in "${GUIX_PREV_ENV[@]}"; do # restore init env
            export "${entry%%=*}=${entry#*=}"
        done
        # active manifests again
        for mani in "${GUIX_ACTIVE_MANIFESTS[@]}"; do
            local profile="${GUIX_EXTRA_PROFILES}/${mani}/${mani}"
            if [ "${mani}" = "${arg}" ]; then # delete from active array
                export GUIX_ACTIVE_MANIFESTS=("${GUIX_ACTIVE_MANIFESTS[@]/$arg}")
            elif [ "${mani}" = "default" ]; then # load profiles
                [ -f "${HOME}"/.guix-profile/etc/profile ] && . "${HOME}"/.guix-profile/etc/profile
                [ -f "${HOME}"/.config/guix/current/etc/profile ] && . "${HOME}"/.config/guix/current/etc/profile
            elif [ -f "${profile}/etc/profile" ]; then
                . "${profile}"/etc/profile
            fi
        done
    fi
}
_guix_activate_profile(){
    local arg="${1}"
    for mani in "${GUIX_ACTIVE_MANIFESTS[@]}"; do
        if [ "${mani}" = "${arg}" ]; then
            return # already active
        fi
    done
    _guix_install_profile "${arg}"
    local profile="${GUIX_EXTRA_PROFILES}/${arg}/${arg}"
    if [ "${arg}" = "default" ];then
        [ -f "${HOME}"/.guix-profile/etc/profile ] && . "${HOME}"/.guix-profile/etc/profile
        [ -f "${HOME}"/.config/guix/current/etc/profile ] && . "${HOME}"/.config/guix/current/etc/profile
        local stash=("${GUIX_PREV_ENV[@]}") # hide prev envs from being saved
        unset GUIX_PREV_ENV
        for mani in "${GUIX_ACTIVE_MANIFESTS[@]}"; do
            local ref="GUIX_PREV_ENV_${mani}"
            local "stash_${mani}=${!ref@}" # TODO: indirect variable expansion portable
            unset "GUIX_PREV_ENV_${mani}"
        done
        local prev=("$(env)") # save profiles env
        export "GUIX_PREV_ENV_${arg}=${prev[*]}"
        export GUIX_PREV_ENV=("${stash[@]}") # restore prev envs
        for mani in "${GUIX_ACTIVE_MANIFESTS[@]}"; do
            local ref="stash_${mani}"
            export "GUIX_PREV_ENV_${mani}=${!ref@}" # TODO: indirect variable expansion portable
        done
        GUIX_ACTIVE_MANIFESTS+=("${arg}") # add to manifests
        export GUIX_ACTIVE_MANIFESTS
    elif [ -f "${profile}"/etc/profile ]; then
        local GUIX_PROFILE="${profile}"
        . "${GUIX_PROFILE}"/etc/profile
        local stash=("${GUIX_PREV_ENV[@]}") # hide prev env from being saved
        unset GUIX_PREV_ENV
        for mani in "${GUIX_ACTIVE_MANIFESTS[@]}"; do
            local ref="GUIX_PREV_ENV_${mani}"
            local "stash_${mani}=${!ref@}" # TODO: indirect variable expansion portable
            unset "GUIX_PREV_ENV_${mani}"
        done
        local prev=("$(env)")
        export "GUIX_PREV_ENV_${arg}=${prev[*]}"
        export GUIX_PREV_ENV=("${stash[@]}") # restore prev env
        for mani in "${GUIX_ACTIVE_MANIFESTS[@]}"; do
            local ref="stash_${mani}"
            export "GUIX_PREV_ENV_${mani}=${!ref@}" # TODO: indirect variable expansion portable
        done
        GUIX_ACTIVE_MANIFESTS+=("${arg}")
        export GUIX_ACTIVE_MANIFESTS
    fi
}
_guix_opts(){
    local help="
     Takes a list of manifest shortnames/commands
     GUIX_MANIFEST_DIR will be set to ${XDG_CONFIG_DIR:-$HOME/.config}/guix-manifests when not set
     GUIX_EXTRA_PROFILES will be set to ${XDG_DATA_HOME:-$HOME/.local/share}/guix-extra-profiles when not set
     GUIX_ACTIVE_MANIFESTS will be set to the profiles that are activated (in order)
     GUIX_PREV_ENV will be set to contents of env without profiles
     GUIX_PREV_ENV_shortname will be set to the contents of env with the profile
     The shortname is the manifest basename to use
     GUIX_MANIFEST_DIR/shortname.scm is the format of manifest search path
     Profiles for manifest will be stored under: GUIX_EXTRA_PROFILES/shortname/shortname
     The commands are activate, update, deactivate and list; activate is the default
     -a|--activate shortname -> sources/installs profile; appends to GUIX_ACTIVE_MANIFESTS
     -d|--deactivate shortname -> restore env before the profile was activated
     -u|--update shortname -> guix package upgrades profile
     -l|--list -> print the contents of GUIX_MANIFEST_DIR as shortnames
     -h|--help -> print this message
"
    _guix_vars
    while [ $# -gt 0 ]; do
        local arg="${1}"
        case "${arg}" in
            -a|--activate)
                _guix_activate_profile "${2}"
                shift 2
                ;;
            -d|--deactivate)
                _guix_deactivate_profile "${2}"
                shift 2
                ;;
            -h|--help)
                printf '%s' "${help}"
                shift
                ;;
            -l|--list)
                _guix_list_manifests
                shift
                ;;
            -u|--update)
                _guix_update_profile "${2}"
                shift 2
                ;;
            *)
                _guix_activate_profile "${1}"
                shift
                ;;
        esac
    done
}
alias guixProf=_guix_opts

_emacs_wrap(){
    # create frame, daemon and pass args
    emacsclient -c -a "" $@
}
alias emacsc="_emacs_wrap"
alias emacskill="_emacs_wrap -e '(kill-emacs)'"
