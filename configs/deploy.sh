#!/bin/bash

ENV_BAK_DIR="$HOME/.g4z3_env_bak/"
mkdir -p $ENV_BAK_DIR
tmp_dir=`mktemp -d -p $ENV_BAK_DIR`
echo "backing up to $tmp_dir"
pwd="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

for orig in emacs emacs-profiles.el gitconfig tmux.conf
do
    echo $orig
    dest="$HOME/.$orig"
    if [ -f "$dest" ]
    then
        cp -r "$dest" "$tmp_dir/.$orig"
        rm -rf "$dest"
    fi
    ln -f -s "$pwd/$orig" "$dest"
done

tools_dir="$HOME/tools"
bak_dir="$tmp_dir/tools"
mkdir -p "$tools_dir"
mkdir -p "$bak_dir"
for t in `ls $pwd/tools`
do
    if [ -f "$tools_dir/$t" ]
    then
        cp -r "$tools_dir/$t" "$bak_dir/"
        rm -rf "$tools_dir/$t"
    fi

    ln -f -s "$pwd/tools/$t" "$tools_dir"
done

# config_systemd_user="$HOME/.config/systemd/user"
# if [ -d "$config_systemd_user" ]
# then
#     cp -r "$config_systemd_user" "$tmp_dir/.config_systemd_user"
#     rm -rf "$config_systemd_user"
# fi
# mkdir -p "$HOME/.config/systemd"
# ln -f -s "$pwd/config/systemd/user" "$config_systemd_user"

# config_autostart="$HOME/.config/autostart"
# if [ -d "$config_autostart" ]
# then
#     cp -r "$config_autostart" "$tmp_dir/.config_autostart"
#     rm -rf "$config_autostart"
# fi
# mkdir -p "$HOME/.config"
# ln -f -s "$pwd/config/autostart" "$config_autostart"

# emax="$HOME/.local/share/applications/emax.desktop"
# if [ -f "$emax" ]
# then
#     cp "$emax" "$tmp_dir/.local_share_applications_emax.desktop"
#     rm -rf "$emax"
# fi
# mkdir -p "$HOME/.local/share/applications/"
# ln -f -s "$pwd/local/share/applications/emax.desktop" "$emax"

gpg --no-use-agent -d ssh.tar.gz.gpg | tar xzvf - -C "$HOME"
ssh="$HOME/.ssh"
if [ -d "$ssh" ]
then
    cp -r "$ssh" "$tmp_dir/.ssh"
    rm -rf "$ssh"
fi
mv "$HOME/ssh" "$ssh"

