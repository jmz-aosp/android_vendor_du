PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

PRODUCT_PROPERTY_OVERRIDES += \
    keyguard.no_require_sim=true \
    dalvik.vm.debug.alloc=0 \
    ro.config.alarm_alert=Oxygen.ogg \
    ro.config.ringtone=Orion.ogg \
    ro.config.notification_sound=Tethys.ogg \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.com.android.wifi-watchlist=GoogleGuest \
    ro.setupwizard.enterprise_mode=1 \
    ro.com.android.dateformat=MM-dd-yyyy \
    ro.build.selinux=1 \
    ro.com.android.dataroaming=false \
    ro.ota.romname=Jmz_AOSP \
    ro.ota.version=1
    ro.ota.manifest=https://raw.githubusercontent.com/jmz-aosp/platform_vendor_jmz/n/rom.xml

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/jmz/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/jmz/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/jmz/prebuilt/common/bin/50-base.sh:system/addon.d/50-base.sh \

# Backup Services whitelist
PRODUCT_COPY_FILES += \
    vendor/jmz/config/permissions/backup.xml:system/etc/sysconfig/backup.xml

# Init file
PRODUCT_COPY_FILES += \
    vendor/jmz/prebuilt/common/etc/init.local.rc:root/init.jmz.rc

# Copy LatinIME for gesture typing
PRODUCT_COPY_FILES += \
    vendor/jmz/prebuilt/common/lib/libjni_latinime.so:system/lib/libjni_latinime.so \
    vendor/jmz/prebuilt/common/lib/libjni_latinimegoogle.so:system/lib/libjni_latinimegoogle.so \
    vendor/jmz/prebuilt/common/lib64/libjni_latinime.so:system/lib64/libjni_latinime.so \
    vendor/jmz/prebuilt/common/lib64/libjni_latinimegoogle.so:system/lib64/libjni_latinimegoogle.so

# SELinux filesystem labels
PRODUCT_COPY_FILES += \
    vendor/jmz/prebuilt/common/etc/init.d/50selinuxrelabel:system/etc/init.d/50selinuxrelabel

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# Don't export PS1 in /system/etc/mkshrc.
PRODUCT_COPY_FILES += \
    vendor/jmz/prebuilt/common/etc/mkshrc:system/etc/mkshrc \

PRODUCT_COPY_FILES += \
    vendor/jmz/prebuilt/common/etc/init.d/00banner:system/etc/init.d/00banner \
    vendor/jmz/prebuilt/common/etc/init.d/90userinit:system/etc/init.d/90userinit \
    vendor/jmz/prebuilt/common/bin/sysinit:system/bin/sysinit

# Stagefright FFMPEG plugin
ifneq ($(BOARD_USES_QCOM_HARDWARE),true)
PRODUCT_PACKAGES += \
    libffmpeg_extractor \
    libffmpeg_omx \
    media_codecs_ffmpeg.xml

PRODUCT_PROPERTY_OVERRIDES += \
    media.sf.omx-plugin=libffmpeg_omx.so \
    media.sf.extractor-plugin=libffmpeg_extractor.so
endif

# Packages
include vendor/jmz/config/packages.mk

PRODUCT_PACKAGE_OVERLAYS += vendor/jmz/overlay/common

# Boot Animation
PRODUCT_COPY_FILES += \
    vendor/jmz/prebuilt/common/media/bootanimation.zip:system/media/bootanimation.zip

# SuperSU
PRODUCT_COPY_FILES += \
    vendor/jmz/prebuilt/common/UPDATE-SuperSU.zip:system/addon.d/UPDATE-SuperSU.zip \
    vendor/jmz/prebuilt/common/etc/init.d/99SuperSUDaemon:system/etc/init.d/99SuperSUDaemon

# Versioning System
ANDROID_VERSION = 7.0
JMZ_VERSION = v1.0
ifndef JMZ_BUILD_TYPE
    JMZ_BUILD_TYPE := DIRTY
    PLATFORM_VERSION_CODENAME := DIRTY
endif

# easy way to extend to add more packages
-include vendor/extra/product.mk

# Set all versions
JMZ_VERSION := Jmz_$(JMZ_BUILD)$(ANDROID_VERSION)_$(shell date -u +%Y%m%d).$(JMZ_VERSION)_$(JMZ_DEVICE)-$(JMZ_BUILD_TYPE)
JMZ_MOD_VERSION := Jmz_$(JMZ_BUILD)$(ANDROID_VERSION)_$(shell date -u +%Y%m%d).$(JMZ_VERSION)_$(JMZ_DEVICE)-$(JMZ_BUILD_TYPE)

PRODUCT_PROPERTY_OVERRIDES += \
    BUILD_DISPLAY_ID=$(BUILD_ID) \
    ro.jmz.version=$(JMZ_VERSION) \
    ro.mod.version=$(JMZ_BUILD_TYPE)-v1.0

