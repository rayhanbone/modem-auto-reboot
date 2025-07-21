module("luci.controller.modem_auto_reboot", package.seeall)
function index()
    entry({"admin", "modem", "modem_auto_reboot"}, cbi("modem-auto-reboot"), _("Reboot Modem"), 100)
end
