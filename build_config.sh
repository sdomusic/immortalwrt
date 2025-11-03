#!/bin/bash
set -e

cd immortalwrt

# === 纯净 x86_64 配置 ===
cat <<'EOF' > .config
CONFIG_TARGET_x86=y
CONFIG_TARGET_x86_64=y
CONFIG_TARGET_x86_64_Generic=y

# 固件空间大小（2048MB）
CONFIG_TARGET_ROOTFS_PARTSIZE=2048

# Luci Web 界面（官方基础版）
CONFIG_PACKAGE_luci=y
CONFIG_PACKAGE_luci-app-firewall=y
CONFIG_PACKAGE_luci-i18n-firewall-zh-cn=y
CONFIG_PACKAGE_luci-app-opkg=y
CONFIG_PACKAGE_luci-theme-bootstrap=y
CONFIG_PACKAGE_luci-i18n-base-zh-cn=y

# 常用工具
CONFIG_PACKAGE_htop=y
CONFIG_PACKAGE_curl=y
CONFIG_PACKAGE_wget=y

# 基础存储支持
CONFIG_PACKAGE_block-mount=y
CONFIG_PACKAGE_kmod-fs-ext4=y
CONFIG_PACKAGE_kmod-usb-storage=y
EOF

make defconfig
