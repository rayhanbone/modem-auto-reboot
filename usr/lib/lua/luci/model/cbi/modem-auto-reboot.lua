-- LuCI CBI model for /etc/config/modem-auto-reboot
-- This UI allows you to configure modem auto reboot parameters from OpenWrt web interface

local m, s, o

m = Map("modem-auto-reboot", translate("Reboot Modem"),
    translate("Otomatis reboot modem jika tidak ada ping. Konfigurasikan parameter di bawah ini sesuai kebutuhan Anda."))

s = m:section(NamedSection, "settings", "settings", translate("Pengaturan Umum"))

o = s:option(Value, "modem_ip", translate("IP Target"))
o.datatype = "ipaddr"
o.placeholder = "192.166.8.1" -- (Diperbarui placeholder agar sesuai dengan contoh yang biasa)

o = s:option(Value, "ping_count", translate("Jumlah Ping"))
o.datatype = "uinteger"
o.placeholder = "3"

o = s:option(Value, "sleep_interval", translate("Interval Cek (detik)"))
o.datatype = "uinteger"
o.placeholder = "60"

o = s:option(Value, "reboot_cmd", translate("Perintah Reboot"))
o.placeholder = "/sbin/reboot"

o = s:option(Value, "log_file", translate("Lokasi File Log"))
o.placeholder = "/tmp/modem-auto-reboot.log"

o = s:option(Value, "log_max_lines", translate("Maksimal Baris Log"))
o.datatype = "uinteger"
o.placeholder = "20"

function m.on_after_commit(map)
    local command = "/etc/init.d/modem-auto-reboot restart"
    local delay_seconds = 3 -- Tentukan berapa detik delay yang diinginkan

    -- Jalankan perintah dengan delay menggunakan 'sleep'
    -- Perintahnya akan seperti: nohup sh -c "sleep 3 && /etc/init.d/modem-auto-reboot restart" &
    os.execute("nohup sh -c \"sleep " .. delay_seconds .. " && " .. command .. "\" &")
end
-- ============================

return m
