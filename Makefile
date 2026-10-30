#
# HomePanel —— LuCI 首页面板
#
# 用法：把整个目录放到 SDK 的 package/luci-app-homepanel/ 下，然后
#   make package/luci-app-homepanel/compile V=s
# 产物在 bin/packages/<arch>/base/luci-app-homepanel_*.ipk
#
# 版本与依赖改这里；纯前端，没有编译步骤，ARCH 固定 all。
#
include $(TOPDIR)/rules.mk

LUCI_TITLE:=HomePanel - LuCI dashboard
LUCI_DESCRIPTION:=A lightweight LuCI dashboard: WAN address, live throughput, \
CPU/memory, latency and online devices in one page. Pure JS, no daemon.
LUCI_DEPENDS:=+luci-base +luci-mod-status
LUCI_PKGARCH:=all

PKG_NAME:=luci-app-homepanel
PKG_VERSION:=1.0.0
PKG_RELEASE:=1
PKG_LICENSE:=MIT
PKG_MAINTAINER:=homepanel

include $(TOPDIR)/feeds/luci/luci.mk

# call BuildPackage - OpenWrt buildroot signature
