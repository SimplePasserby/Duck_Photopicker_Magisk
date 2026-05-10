#!/system/bin/sh
#
# Wait for full boot
#while [ "$(getprop sys.boot_completed)" != "1" ]; do 
#    sleep 1
#done
#sleep 5

# List of components to disable (class names only, the package is com.android.providers.media.module)
COMPONENTS="
com.android.providers.media.photopicker.PhotoPickerGetContentActivity
com.android.providers.media.photopicker.PhotoPickerUserSelectActivity
com.android.providers.media.photopicker.PhotoPickerActivity
"

# Loop over all users (main user, work profile, private space, etc.)
for USER_ID in $(pm list users | grep -o 'UserInfo{[^}]*' | grep -o 'id=[0-9]*' | cut -d= -f2); do
    for COMP in $COMPONENTS; do
        pm disable --user $USER_ID "com.android.providers.media.module/$COMP"
    done
done