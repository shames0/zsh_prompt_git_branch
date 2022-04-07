autoload -U colors && colors  # enable use of colors
setopt PROMPT_SUBST  # allow for calling functions in PROMPT definition

get_branch() {
    [ -z "$(git rev-parse --show-toplevel 2>/dev/null)" ] && return 1;
    cur_branch=$(git branch 2>/dev/null | sed -n '/^\*/s/^\* //p')
    [ -z "${cur_branch}" ] && return 1;
    git diff --quiet 2>&1 1>/dev/null || { echo "%{$fg[red]%}($cur_branch)%{$reset_color%}" && return 0; }
    git diff --quiet --staged 2>&1 1>/dev/null || { echo "%{$fg[yellow]%}($cur_branch)%{$reset_color%}" && return 0; }
    echo "%{$fg[green]%}($cur_branch)%{$reset_color%}"
    return 0
}

PROMPT='%m:%1~ %n$(get_branch)$ '
