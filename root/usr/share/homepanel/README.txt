HomePanel — LuCI 首页面板
==========================

一个纯前端的 LuCI 首页，用 ubus 现有接口取数，不装后台进程，
不改网络/防火墙/任何 UCI 配置。卸载即回原样。
不依赖具体机型或接口命名，N60 / 软路由 / 任何跑 JS 版 LuCI 的设备都能装。

入口：登录后台后「状态 → 首页」，根路径 http://<路由器IP>/cgi-bin/luci/ 也会落到这里。
想让它排到「概览」后面：把 /usr/share/luci/menu.d/luci-app-homepanel.json
里的 "order" 从 0 改成 10，再 rm -f /tmp/luci-indexcache*。

数据来源
--------
公网地址 / 在线时长  network.interface dump（不写死 wan / wan6 命名）
实时吞吐 / 曲线      luci.getRealtimeStats（需 60 秒采样窗口）
CPU / 内存 / 温度    /proc/stat、/proc/loadavg、system.info、thermal_zone、
                     luci.getCPUInfo / getTempInfo（后者不存在时自动拼接）
延迟                file.exec: /bin/ping -c 3 -W 1 -q 223.5.5.5
在线设备 / 每台流量  luci.bandix（可选）
                    没装 bandix 时退回 /proc/net/arp + DHCP 租约：
                    能看在线设备与 IP，但速率/今日两列没有数据来源，会自动隐藏

可选依赖
--------
luci-app-bandix  装上后设备表才有「每台速率 / 今日流量」两列。
它不在官方源里，需要自己编译，或者用固件里自带的版本。

已知限制
--------
* 只有中文界面，没有 i18n。
* 需要 LuCI 的 JS 版视图（OpenWrt 21.02 及以后；不含 19.07 及更早的 Lua CBI 界面）。
* 菜单权限写在 luci-app-homepanel（ACL），只给「读」权限，没有写操作。
* 第一个 2 秒内 CPU 使用率显示「—」，因为 /proc/stat 是累计值，需要两次采样相减。

文件
----
/www/luci-static/resources/view/homepanel/dashboard.js   页面逻辑
/www/luci-static/resources/homepanel/app.css             样式
/usr/share/luci/menu.d/luci-app-homepanel.json           菜单
/usr/share/rpcd/acl.d/luci-app-homepanel.json            权限

卸载：opkg remove luci-app-homepanel && rm -f /tmp/luci-indexcache*
（早期版本曾用名 luci-app-n60home，如装过请先 opkg remove luci-app-n60home）

许可：MIT
