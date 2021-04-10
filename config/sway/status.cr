require "json"

# Status line for Sway.
#
# Usage:
#
# bar {
#   status_command crystal ~/.config/sway/status.cr
# }
#
# Protocol: https://github.com/swaywm/sway/blob/master/swaybar/swaybar-protocol.7.scd

# Write the status line to standard output.
spawn do
  header = { version: 1, click_events: true }

  puts(header.to_json, "[")

  loop do
    status_line = [
      { :name => "battery", :full_text => "%s%%" % File.open("/sys/class/power_supply/BAT1/capacity").gets },
      { :name => "time", :full_text => Time.local.to_s("%A %F %R") }
    ]

    puts(status_line.to_json, ",")
    sleep(10)
  end
end

# Read events from standard input.
spawn do
  # Skips "["
  STDIN.gets

  STDIN.each_line do |line|
    # Strips "," to parse a valid chunk.
    click_event = JSON.parse(line.strip(','))

    case { click_event["name"], click_event["button"] }
    when { "time", 1 }
      Process.run("notify-send", { "time clicked" })
    when { "battery", 1 }
      Process.run("notify-send", { "battery clicked" })
    end
  end
end

sleep
