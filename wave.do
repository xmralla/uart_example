onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /uart_tb/clk
add wave -noupdate -radix hexadecimal /uart_tb/txdata1
add wave -noupdate -radix hexadecimal /uart_tb/txdata2
add wave -noupdate -radix hexadecimal /uart_tb/rxdata1
add wave -noupdate -radix hexadecimal /uart_tb/rxdata2
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {4732 ps}

run 4000
