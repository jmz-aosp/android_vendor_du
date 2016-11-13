# Theme engine
PRODUCT_PACKAGES += \
    aapt \
    ThemeChooser \
    ThemesProvider

PRODUCT_COPY_FILES += \
    vendor/jmz/config/permissions/com.tmobile.software.themes.xml:system/etc/permissions/com.tmobile.software.themes.xml \
    vendor/jmz/config/permissions/org.cyanogenmod.theme.xml:system/etc/permissions/org.cyanogenmod.theme.xml
