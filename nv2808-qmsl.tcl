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

puts $channel "<NvSource>"
puts -nonewline $channel "<NvItem id=\"2808\" subscriptionid=\"0\" name=\"NV_SW_VERSION_INFO_I\" mapping=\"direct\" encoding=\"dec\" index=\"0\">"
puts -nonewline $channel "[scan [string index $version 0] %c]"

set len [string length $version]
if {$len > 30} {
   set len 30
}
for {set count 1} {$count < $len} {incr count} {
    puts  -nonewline $channel ",[scan [string index $version $count] %c]"
}

for {set count $len} {$count < 30} {incr count} {
    puts -nonewline $channel ",0"
}

puts $channel "</NvItem>"
puts $channel "</NvSource>"

close $channel
