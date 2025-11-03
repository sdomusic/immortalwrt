#!/bin/bash
# =========================================
# DIY Script for ImmortalWrt GitHub Actions
# =========================================

echo "=== Running DIY Script ==="

# 1️⃣ 修改默认 IP
sed -i 's/192.168.1.1/192.168.2.3/g' package/base-files/files/bin/config_generate

# 2️⃣ 修改默认主机名
sed -i 's/OpenWrt/ImmortalWrt/g' package/base-files/files/bin/config_generate

# 3️⃣ 设置默认主题为 Argon
sed -i 's/uci set luci.main.mediaurlbase=.*$/uci set luci.main.mediaurlbase=\/luci-static\/argon/g' package/feeds/luci/luci-theme-argon/root/etc/uci-defaults/20_luci-theme-argon || echo "skip theme"

# 4️⃣ 添加自定义 Feed
# 如果源码里没有 openclash，可以添加
echo 'src-git small https://github.com/vernesong/OpenClash.git' >> feeds.conf.default

# 5️⃣ 更新 feeds 并安装插件
./scripts/feeds update -a
./scripts/feeds install -a luci-app-openclash || echo "OpenClash feed not found, skip"

# 6️⃣ 其他常用系统优化插件（可选）
# 启用 zram
sed -i 's/# CONFIG_PACKAGE_zram-swap is not set/CONFIG_PACKAGE_zram-swap=y/' .config || echo "skip zram"

# 启用 htop
sed -i 's/# CONFIG_PACKAGE_htop is not set/CONFIG_PACKAGE_htop=y/' .config || echo "skip htop"

echo "=== DIY Script Finished ==="
