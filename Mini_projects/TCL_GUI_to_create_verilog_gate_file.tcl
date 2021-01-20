proc GATE {arg tg} {
set module_name [.eModule get]
set first_input [.eFirst get]
set second_input [.eSecond get]
set output [.eOutput get]
#condition for gate
if {$tg == "gate"} {
set compliment ""
if {$arg == "and"} {
set symbol "&"
.and config -text "Sucessfull" -bg blue
} elseif {$arg == "nand"} {
set symbol "&"
set compliment "~"
.nand config -text "Sucessfull" -bg blue
} elseif {$arg == "or"} {
set symbol "|"
.or config -text "Sucessfull" -bg blue
} elseif {$arg == "nor"} {
set symbol "|"
set compliment "~"
.nor config -text "Sucessfull" -bg blue
} elseif {$arg == "xor"} {
set symbol "^"
.xor config -text "Sucessfull" -bg blue
} else {
set symbol ""
}
#Writing module file
set mod ${module_name}.v
set Wmode [open "$mod" w+]
puts $Wmode "module $module_name ($output, $first_input, $second_input);"
puts $Wmode "output $output;"
puts $Wmode "input $first_input, $second_input;"
puts $Wmode "assign $output = $compliment ($first_input $symbol $second_input);"
puts $Wmode "endmodule"
# close Wmode
} elseif {$tg == "testbench"} {
if {$arg == "and"} { .andt config -text "Sucessfull" -bg blue
} elseif {$arg == "nand"} { .nandt config -text "Sucessfull" -bg blue
} elseif {$arg == "or"} { .ort config -text "Sucessfull" -bg blue
} elseif {$arg == "nor"} { .nort config -text "Sucessfull" -bg blue
} elseif {$arg == "xor"} { .xort config -text "Sucessfull" -bg blue
}
set tb_mod tb_${module_name}.v
set Wmode [open "$tb_mod" w+]
puts $Wmode "module tb_$module_name ();"
puts $Wmode "reg $first_input, $second_input;"
puts $Wmode "wire $output;\n"
puts $Wmode "$module_name uut (.$output\($output), \
.$first_input\($first_input), .$second_input\($second_input));\n"
puts $Wmode "initial begin;"
puts $Wmode "#10 $first_input=1'b0; $second_input=1'b0;"
puts $Wmode "#10 $first_input=1'b0; $second_input=1'b1;"
puts $Wmode "#10 $first_input=1'b1; $second_input=1'b0;"
puts $Wmode "#10 $first_input=1'b1; $second_input=1'b1;"
puts $Wmode "end"
puts $Wmode "endmodule"
}
}
label .lModule -text "Enter module name" -relief groove -width 20 -justify left
label .lFirst -text "Enter first input" -relief groove -width 20 -justify left
label .lSecond -text "Enter second input" -relief groove -width 20 -justify left
label .lOutput -text "Enter output" -relief groove -width 20 -justify left
button .and -text "AND Gate" -bg teal -fg white -width 20 -command {GATE "and" "gate"}
button .andt -text "AND testbench" -bg teal -fg white -width 16 -command {GATE "and" "testbench"}
button .nand -text "NAND Gate" -bg teal -fg white -width 20 -command {GATE "nand" "gate"}
button .nandt -text "NAND testbench" -bg teal -fg white -width 16 -command {GATE "nand" "testbench"}
button .or -text "OR Gate" -bg teal -fg white -width 20 -command {GATE "or" "gate"}
button .ort -text "OR testbench" -bg teal -fg white -width 16 -command {GATE "or" "testbench"}
button .nor -text "NOR Gate" -bg teal -fg white -width 20 -command {GATE "nor" "gate"}
button .nort -text "NOR_testbench" -bg teal -fg white -width 16 -command {GATE "nor" "testbench"}
button .xor -text "XOR Gate" -bg teal -fg white -width 20 -command {GATE "xor" "gate"}
button .xort -text "XOR_testbench" -bg teal -fg white -width 16 -command {GATE "xor" "testbench"}
entry .eModule -relief groove -width 20
bind .eModule <Return> {.lModule config -text "Module name entered" -bg green -fg white
.eModule config -bg green -fg white}
entry .eFirst -relief groove -width 20
bind .eFirst <Return> {.lFirst config -text "First input name entered" -bg green -fg white
.eFirst config -bg green -fg white}
entry .eSecond -relief groove -width 20
bind .eSecond <Return> {.lSecond config -text "Second input entered" -bg green -fg white
.eSecond config -bg green -fg white}
entry .eOutput -relief groove -width 20
bind .eOutput <Return> {.lOutput config -text "Output entered" -bg green -fg white
.eOutput config -bg green -fg white}
grid .lModule -row 0 -column 0
grid .lFirst -row 1 -column 0
grid .lSecond -row 2 -column 0
grid .lOutput -row 3 -column 0
grid .eModule -row 0 -column 1
grid .eFirst -row 1 -column 1
grid .eSecond -row 2 -column 1
grid .eOutput -row 3 -column 1
grid .and -row 4 -column 0
grid .andt -row 4 -column 1
grid .nand -row 5 -column 0
grid .nandt -row 5 -column 1
grid .or -row 6 -column 0
grid .ort -row 6 -column 1
grid .nor -row 7 -column 0
grid .nort -row 7 -column 1
grid .xor -row 8 -column 0
grid .xort -row 8 -column 1
