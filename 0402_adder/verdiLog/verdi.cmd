simSetSimulator "-vcssv" -exec "./simv" -args
debImport "-dbdir" "./simv.daidir"
debLoadSimResult /home/hedu14/AHN/0402_adder/wave.fsdb
wvCreateWindow
verdiSetActWin -win $_nWave2
verdiWindowResize -win $_Verdi_1 "1453" "279" "900" "700"
verdiWindowResize -win $_Verdi_1 "1453" "279" "900" "700"
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
srcDeselectAll -win $_nTrace1
srcHBSelect "tb_adder.dut" -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcHBSelect "tb_adder.dut" -win $_nTrace1
srcHBSelect "tb_adder.dut" -win $_nTrace1
srcHBSelect "tb_adder.dut" -win $_nTrace1
srcSetScope "tb_adder.dut" -delim "." -win $_nTrace1
srcHBSelect "tb_adder.dut" -win $_nTrace1
srcHBSelect "tb_adder.dut" -win $_nTrace1
srcHBSelect "tb_adder.dut" -win $_nTrace1
srcHBSelect "tb_adder" -win $_nTrace1
srcHBSelect "tb_adder.dut" -win $_nTrace1
srcHBSelect "tb_adder" -win $_nTrace1
srcHBSelect "tb_adder" -win $_nTrace1
srcSetScope "tb_adder" -delim "." -win $_nTrace1
srcHBSelect "tb_adder" -win $_nTrace1
srcHBSelect "tb_adder.dut" -win $_nTrace1
srcHBDrag -win $_nTrace1
wvSetPosition -win $_nWave2 {("dut" 0)}
wvRenameGroup -win $_nWave2 {G1} {dut}
wvAddSignal -win $_nWave2 "/tb_adder/dut/a\[7:0\]" "/tb_adder/dut/b\[7:0\]" \
           "/tb_adder/dut/y\[8:0\]"
wvSetPosition -win $_nWave2 {("dut" 0)}
wvSetPosition -win $_nWave2 {("dut" 3)}
wvSetPosition -win $_nWave2 {("dut" 3)}
verdiSetActWin -win $_nWave2
wvSelectGroup -win $_nWave2 {G2}
wvSelectSignal -win $_nWave2 {( "dut" 3 )} 
wvSelectGroup -win $_nWave2 {G2}
srcTBInvokeSim
verdiSetActWin -win $_InteractiveConsole_3
verdiSetActWin -dock widgetDock_<Member>
verdiDockWidgetSetCurTab -dock windowDock_nWave_2
verdiSetActWin -win $_nWave2
srcTBRunSim
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoom -win $_nWave2 9406.555197 24770.595353
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomOut -win $_nWave2
verdiWindowResize -win $_Verdi_1 "1470" "229" "900" "700"
wvZoomAll -win $_nWave2
srcDeselectAll -win $_nTrace1
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
srcDeselectAll -win $_nTrace1
srcSelect -signal "a" -line 2 -pos 1 -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "b" -line 3 -pos 1 -win $_nTrace1
srcTBInsertDataTree -win $_nTrace1 -tab 1 -tree "tb_adder.b\[7:0\]"
srcDeselectAll -win $_nTrace1
srcSelect -signal "y" -line 4 -pos 1 -win $_nTrace1
srcAction -pos 3 9 0 -win $_nTrace1 -name "y" -ctrlKey off
srcHBSelect "tb_adder" -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcHBSelect "tb_adder" -win $_nTrace1
srcSetScope "tb_adder" -delim "." -win $_nTrace1
srcHBSelect "tb_adder" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "y" -line 4 -pos 1 -win $_nTrace1
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
srcTBInsertDataTree -win $_nTrace1 -tab 1 -tree "tb_adder.y\[8:0\]"
srcDeselectAll -win $_nTrace1
srcSelect -signal "a" -line 2 -pos 1 -win $_nTrace1
srcTBInsertDataTree -win $_nTrace1 -tab 1 -tree "tb_adder.a\[7:0\]"
verdiWindowResize -win $_Verdi_1 "1470" "229" "1032" "700"
verdiSetActWin -dock widgetDock_<Watch>
srcSelect -win $_nTrace1 -range {14 14 1 9 1 1}
srcTBAddBrkPnt -line 14 -file /home/hedu14/AHN/0402_adder/tb_adder.sv
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
srcTBSimReset
srcTBRunSim
srcTBDVSelect -tab 1 -range {1-1} 
verdiSetActWin -dock widgetDock_<Watch>
srcTBDVSelect -tab 1 -range {2-2} 
srcTBStepNext
srcTBStepNext
srcTBStepNext
srcTBStepNext
srcTBStepNext
srcTBStepNext
srcTBStepNext
srcTBStepNext
srcTBStepNext
verdiSetActWin -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
srcTBStepNext
srcTBStepNext
srcTBStepNext
srcTBStepNext
srcTBStepNext
srcTBStepNext
srcTBStepNext
srcTBStepNext
srcTBStepNext
srcTBStepNext
srcTBStepNext
srcTBStepNext
srcTBStepNext
srcTBStepNext
srcTBStepNext
verdiDockWidgetSetCurTab -dock windowDock_InteractiveConsole_3
verdiSetActWin -win $_InteractiveConsole_3
srcTBStepNext
srcTBStepNext
srcTBStepNext
srcTBStepNext
srcTBStepNext
srcTBStepNext
verdiDockWidgetSetCurTab -dock windowDock_nWave_2
verdiSetActWin -win $_nWave2
verdiWindowResize -win $_Verdi_1 "1470" "163" "1032" "766"
verdiWindowResize -win $_Verdi_1 "1470" "163" "1032" "942"
verdiWindowResize -win $_Verdi_1 "1470" "163" "1032" "1084"
verdiWindowResize -win $_Verdi_1 "1470" "163" "1032" "1084"
wvZoomAll -win $_nWave2
wvSetCursor -win $_nWave2 35880.000000 -snap {("dut" 2)}
wvSetCursor -win $_nWave2 30960.000000 -snap {("dut" 2)}
wvSelectSignal -win $_nWave2 {( "dut" 2 )} 
wvSelectSignal -win $_nWave2 {( "dut" 3 )} 
wvSelectSignal -win $_nWave2 {( "dut" 2 )} 
wvSelectSignal -win $_nWave2 {( "dut" 1 )} 
wvSelectSignal -win $_nWave2 {( "dut" 2 )} 
wvSelectSignal -win $_nWave2 {( "dut" 2 )} 
wvSelectSignal -win $_nWave2 {( "dut" 3 )} 
wvSelectGroup -win $_nWave2 {G2}
wvSelectSignal -win $_nWave2 {( "dut" 3 )} 
wvSelectSignal -win $_nWave2 {( "dut" 3 )} 
wvSelectSignal -win $_nWave2 {( "dut" 2 )} 
wvSelectSignal -win $_nWave2 {( "dut" 1 )} 
srcTBDVSelect -tab 1 -range {0-0} 
srcTBDVSelect -tab 1 -range {1-1} 
verdiSetActWin -dock widgetDock_<Watch>
srcTBDVSelect -tab 1 -range {2-2} 
nsMsgSwitchTab -tab general
debExit
