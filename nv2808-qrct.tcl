#!/usr/bin/tclsh
#
# A simple program to generate a file nv-2808.xml (NV XML file format).
# When we use nv 2808 to record a XQCN SW version, use this file to merge.
#

set channel [open "nv-2808.xml" "w+"]
if { $::argc > 0 } {
    set version [lindex $::argv 0]
} else {
    puts -nonewline "Please input a version: "
    flush stdout
    gets stdin version
}

puts $channel "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
puts $channel "<NvSource xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\">"
puts $channel " <NvItemData id=\"2808\" name=\"NV_SW_VERSION_INFO_I\" subscriptionid=\"0\" variableSize=\"false\" index=\"0\" compressed=\"false\">"
puts $channel "  <Member type=\"uint8\" name=\"UNKNOWN\" sizeOf=\"2\">[scan [string index $version 0] %c] [scan [string index $version 1] %c]</Member>"

set len [string length $version]
if {$len > 30} {
   set len 30
}
for {set count 2} {$count < $len} {incr count} {
    puts $channel "  <Member type=\"uint8\" name=\"UNKNOWN\" sizeOf=\"1\">[scan [string index $version $count] %c]</Member>"
}

for {set count $len} {$count < 30} {incr count} {
    puts $channel "  <Member type=\"uint8\" name=\"UNKNOWN\" sizeOf=\"1\">0</Member>"
}

puts $channel " </NvItemData>"
puts $channel "</NvSource>"

close $channel
