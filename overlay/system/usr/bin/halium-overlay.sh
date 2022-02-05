HALIUM_OVERLAY="$(find /opt/halium-overlay/ -type f -print)"
for overlay in $HALIUM_OVERLAY
do
    destination="$(echo $overlay | sed -e 's/\/opt\/halium-overlay\///')"
    mount -o bind "$overlay" "/android/$destination"
done
