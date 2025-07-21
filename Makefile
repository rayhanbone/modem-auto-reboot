# Define the package name and version
PKG_NAME:=modem-auto-reboot
PKG_VERSION:=1.0.0
PKG_RELEASE:=1

# Define where to put the package files
# This is a dummy source, as we're directly including files from the repo
PKG_SOURCE:=
PKG_SOURCE_URL:=
PKG_HASH:=

# --- PENTING: Pastikan ini mengarah ke lua-package.mk yang disalin ke direktori paket Anda ---
include $(TOPDIR)/package/$(PKG_NAME)/lua-package.mk

# Define where the package will be built
# This will copy files from your GitHub repo into the package structure
define Package/modem-auto-reboot
  SECTION:=net
  CATEGORY:=Network
  TITLE:=Modem Auto Rebooter
  DEPENDS:=+ping +luci-lib-ipkg
  # Optional: Specify a human-readable description
  DESCRIPTION:=Automatically reboots modem if no ping response, configurable via LuCI.
endef

# Define what files to install into the package
# We copy files directly from the current directory (GitHub repo)
define Package/modem-auto-reboot/install
	# Pastikan $(1) digunakan dengan benar untuk direktori instalasi target
	# Path sumber (./etc/init.d/...) harus relatif terhadap direktori Makefile paket Anda
	# (yaitu, '/home/runner/work/modem-auto-reboot/modem-auto-reboot/openwrt-build/package/modem-auto-reboot/')

	# Instal skrip init.d
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_DATA) ./etc/init.d/modem-auto-reboot $(1)/etc/init.d/modem-auto-reboot

	# Instal skrip LuCI CBI
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/model/cbi
	$(INSTALL_DATA) ./usr/lib/lua/luci/model/cbi/modem-auto-reboot.lua $(1)/usr/lib/lua/luci/model/cbi/modem-auto-reboot.lua

	# Optional: Jika Anda memiliki file konfigurasi default (misal: /etc/config/modem-auto-reboot)
	# $(INSTALL_DIR) $(1)/etc/config
	# $(INSTALL_CONF) ./etc/config/modem-auto-reboot $(1)/etc/config/modem-auto-reboot

	# Optional: Jika Anda memiliki file ucitrack
	# $(INSTALL_DIR) $(1)/etc/config
	# $(INSTALL_CONF) ./etc/config/ucitrack $(1)/etc/config/ucitrack
endef

$(eval $(call BuildPackage,modem-auto-reboot))
