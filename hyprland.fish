#!/usr/bin/env fish

if not test -f /run/udev/data/+drm:card1-HDMI-A-1
    sudo systemctl restart systemd-udev-trigger > /dev/null
end

# Uncomment and use this section if desired
# if not status --is-status iwd "active (running)"
#     sudo systemctl start iwd &
# end

while not test -f /run/udev/data/+drm:card1-HDMI-A-1
    echo "waiting for drm"
    sleep 0.2
end

set -gx USER "mike"
test -z "$TERM"; and set -gx TERM "linux"
test -z "$LOGNAME"; and set -gx LOGNAME "$USER"
test -z "$HOME"; and set -gx HOME "/home/$USER"
test -z "$LANG"; and set -gx LANG "C.UTF-8"
test -z "$PATH"; and set -gx PATH "/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl"
test -z "$XDG_SEAT"; and set -gx XDG_SEAT "seat0"
test -z "$XDG_SESSION_TYPE"; and set -gx XDG_SESSION_TYPE "tty"
test -z "$XDG_SESSION_CLASS"; and set -gx XDG_SESSION_CLASS "user"
test -z "$XDG_VTNR"; and set -gx XDG_VTNR "1"
test -z "$XDG_RUNTIME_DIR"; and set -gx XDG_RUNTIME_DIR "/run/user/1000"
test -z "$DBUS_SESSION_BUS_ADDRESS"; and set -gx DBUS_SESSION_BUS_ADDRESS "unix:path=/run/user/1000/bus"

set -gx HYPRLAND_LOG_WLR "1"
set -gx XCURSOR_SIZE "24"

# Change the theme here
set -gx XCURSOR_THEME "Bibata-Modern-Classic"

if not test -f /run/udev/data/+drm:card1-HDMI-A-1
    echo "Hyprland needs drm, bailing out"
    exit 1
end
exec Hyprland > .hyprland.log.txt 2> .hyprland.err.txt


