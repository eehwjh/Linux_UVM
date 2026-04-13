verdiWindowResize -win $_vdCoverage_1 "830" "370" "900" "700"
gui_set_pref_value -category {coveragesetting} -key {geninfodumping} -value 1
gui_exclusion -set_force true
verdiSetFont  -font  {DejaVu Sans}  -size  11
verdiSetFont -font "DejaVu Sans" -size "11"
gui_assert_mode -mode flat
gui_class_mode -mode hier
gui_excl_mgr_flat_list -on  0
gui_covdetail_select -id  CovDetail.1   -name   Line
verdiWindowWorkMode -win $_vdCoverage_1 -coverageAnalysis
verdiSetActWin -dock widgetDock_Message
gui_open_cov  -hier coverage.vdb -testdir {} -test {coverage/sim1} -merge MergedTest -db_max_tests 10 -sdc_level 1 -fsm transition
verdiWindowResize -win $_vdCoverage_1 "830" "370" "1015" "709"
gui_list_select -id CoverageTable.1 -list covtblInstancesList { uvm_pkg   }
verdiSetActWin -dock widgetDock_<Summary>
gui_list_action -id  CoverageTable.1 -list {covtblInstancesList} uvm_pkg  -column {} 
gui_covtable_show -show  { Design Hierarchy } -id  CoverageTable.1  -test  MergedTest
verdiSetActWin -dock widgetDock_<CovSrc.1>
verdiSetActWin -dock widgetDock_<Summary>
gui_list_select -id CovDetail.1 -list Cover { {Cover properties}   } -type { {}  }
verdiSetActWin -dock widgetDock_<CovDetail>
gui_list_action -id  CoverageTable.1 -list {covtblInstancesList} uvm_pkg  -column {Assert} 
verdiSetActWin -dock widgetDock_<Summary>
gui_list_action -id  CoverageTable.1 -list {covtblInstancesList} uvm_pkg  -column {} 
gui_list_action -id  CoverageTable.1 -list {covtblInstancesList} uvm_pkg  -column {} 
gui_list_action -id  CoverageTable.1 -list {covtblInstancesList} uvm_pkg  -column {} 
gui_list_action -id  CoverageTable.1 -list {covtblInstancesList} uvm_pkg  -column {} 
verdiWindowResize -win $_vdCoverage_1 "1021" "300" "1397" "709"
gui_covtable_show -show  { Function Groups } -id  CoverageTable.1  -test  MergedTest
gui_list_select -id CoverageTable.1 -list covtblFGroupsList { {/$unit::counter_coverage::counter_cg}   }
gui_covtable_show -show  { Design Hierarchy } -id  CoverageTable.1  -test  MergedTest
gui_covtable_show -show  { Module List } -id  CoverageTable.1  -test  MergedTest
gui_covtable_show -show  { Design Hierarchy } -id  CoverageTable.1  -test  MergedTest
gui_covtable_show -show  { Function Groups } -id  CoverageTable.1  -test  MergedTest
gui_list_expand -id  CoverageTable.1   -list {covtblFGroupsList} {/$unit::counter_coverage::counter_cg}
gui_list_expand -id CoverageTable.1   {/$unit::counter_coverage::counter_cg}
gui_list_action -id  CoverageTable.1 -list {covtblFGroupsList} {/$unit::counter_coverage::counter_cg}  -column {} 
verdiWindowResize -win $_vdCoverage_1 "1257" "249" "1314" "696"
verdiWindowResize -win $_vdCoverage_1 "1257" "73" "1314" "872"
verdiWindowResize -win $_vdCoverage_1 "1257" "73" "1314" "1111"
verdiWindowResize -win $_vdCoverage_1 "1294" "73" "1277" "1111"
verdiDockWidgetMaximize -dock widgetDock_<CovDetail>
verdiSetActWin -dock widgetDock_<CovDetail>
verdiDockWidgetUndock -dock widgetDock_<CovDetail>
verdiDockWidgetDock -dock widgetDock_<CovDetail>
verdiDockWidgetHide -dock widgetDock_<CovDetail>
verdiSetActWin -dock widgetDock_Message
gui_covtable_show -show  { Asserts } -id  CoverageTable.1  -test  MergedTest
gui_list_expand -id  CoverageTable.1   -list {covtblStatAssertInstList} Assertion
gui_list_expand -id  CoverageTable.1   -list {covtblStatAssertInstList} {Cover Property}
gui_list_expand -id  CoverageTable.1   -list {covtblStatAssertInstList} {Cover Sequence}
gui_list_expand -id  CoverageTable.1   -list {covtblStatAssertInstList} Total
gui_covtable_show -show  { Function Groups } -id  CoverageTable.1  -test  MergedTest
verdiSetActWin -dock widgetDock_<Summary>
gui_list_sort -id  CoverageTable.1   -list {covtblFGroupsList} {Score}
gui_list_action -id  CoverageTable.1 -list {covtblFGroupsList} {/$unit::counter_coverage::counter_cg}  -column {Group} 
verdiSetActWin -dock widgetDock_<CovDetail>
gui_list_select -id CoverageTable.1 -list covtblFGroupsList { {/$unit::counter_coverage::counter_cg}  {$unit::counter_coverage::counter_cg.cx_en_count}   }
gui_list_select -id CoverageTable.1 -list covtblFGroupsList { {$unit::counter_coverage::counter_cg.cx_en_count}  {$unit::counter_coverage::counter_cg.cx_rst_en}   }
verdiSetActWin -dock widgetDock_<Summary>
gui_list_select -id CoverageTable.1 -list covtblFGroupsList { {$unit::counter_coverage::counter_cg.cx_rst_en}  {$unit::counter_coverage::counter_cg.cx_en_count}   }
gui_list_collapse -id  CoverageTable.1   -list {covtblFGroupsList} {/$unit::counter_coverage::counter_cg}
gui_list_expand -id  CoverageTable.1   -list {covtblFGroupsList} {/$unit::counter_coverage::counter_cg}
gui_list_expand -id CoverageTable.1   {/$unit::counter_coverage::counter_cg}
gui_list_action -id  CoverageTable.1 -list {covtblFGroupsList} {/$unit::counter_coverage::counter_cg}  -column {Group} 
gui_list_select -id CoverageTable.1 -list covtblFGroupsList { {$unit::counter_coverage::counter_cg.cx_en_count}  {$unit::counter_coverage::counter_cg.cx_rst_en}   }
gui_list_select -id CoverageTable.1 -list covtblFGroupsList { {$unit::counter_coverage::counter_cg.cx_rst_en}  {$unit::counter_coverage::counter_cg.cp_count}   }
gui_list_select -id CoverageTable.1 -list covtblFGroupsList { {$unit::counter_coverage::counter_cg.cp_count}  {$unit::counter_coverage::counter_cg.cp_enable}   }
gui_list_select -id CoverageTable.1 -list covtblFGroupsList { {$unit::counter_coverage::counter_cg.cp_enable}  {$unit::counter_coverage::counter_cg.cp_rst_n}   }
gui_list_select -id CoverageTable.1 -list covtblFGroupsList { {$unit::counter_coverage::counter_cg.cp_rst_n}  {$unit::counter_coverage::counter_cg.cx_rst_en}   }
gui_list_select -id CoverageTable.1 -list covtblFGroupsList { {$unit::counter_coverage::counter_cg.cx_rst_en}  {$unit::counter_coverage::counter_cg.cx_en_count}   }
gui_list_select -id CovDetail.1 -list covergroup { {$unit::counter_coverage::counter_cg.cx_en_count}  {$unit::counter_coverage::counter_cg.cx_rst_en}   } -type { {Cover Group} {Cover Group}  }
verdiSetActWin -dock widgetDock_<CovDetail>
gui_list_select -id CovDetail.1 -list covergroup { {$unit::counter_coverage::counter_cg.cx_rst_en}  {$unit::counter_coverage::counter_cg.cx_en_count}   } -type { {Cover Group} {Cover Group}  }
gui_list_select -id CovDetail.1 -list covergroup { {$unit::counter_coverage::counter_cg.cx_en_count}  {$unit::counter_coverage::counter_cg.cp_rst_n}   } -type { {Cover Group} {Cover Group}  }
gui_list_select -id CovDetail.1 -list covergroup { {$unit::counter_coverage::counter_cg.cp_rst_n}  {$unit::counter_coverage::counter_cg.cp_count}   } -type { {Cover Group} {Cover Group}  }
gui_list_select -id CovDetail.1 -list {covergroup detail} { high   }
gui_list_select -id CovDetail.1 -list {covergroup detail} { high  low   }
gui_list_select -id CovDetail.1 -list {covergroup detail} { low  zero   }
gui_list_select -id CovDetail.1 -list {covergroup detail} { zero  max   }
gui_list_select -id CovDetail.1 -list {covergroup detail} { max  zero   }
verdiWindowResize -win $_vdCoverage_1 "964" "73" "1584" "1111"
verdiWindowResize -win $_vdCoverage_1 "1132" "255" "1410" "1005"
gui_list_select -id CovDetail.1 -list {covergroup detail} { zero  max   }
gui_list_select -id CovDetail.1 -list {covergroup detail} { max  low   }
gui_list_select -id CovDetail.1 -list {covergroup detail} { low  high   }
gui_list_select -id CovDetail.1 -list {covergroup detail} { high  low   }
gui_list_select -id CovDetail.1 -list {covergroup detail} { low  max   }
gui_list_select -id CovDetail.1 -list {covergroup detail} { max  zero   }
gui_list_select -id CovDetail.1 -list {covergroup detail} { zero  max   }
gui_list_select -id CovDetail.1 -list {covergroup detail} { max  low   }
gui_list_select -id CovDetail.1 -list {covergroup detail} { low  high   }
gui_list_select -id CovDetail.1 -list {covergroup detail} { high  low   }
gui_list_select -id CovDetail.1 -list {covergroup detail} { low  max   }
gui_list_select -id CovDetail.1 -list {covergroup detail} { max  zero   }
gui_list_select -id CovDetail.1 -list {covergroup detail} { zero  max   }
gui_list_select -id CovDetail.1 -list {covergroup detail} { max  zero   }
gui_list_select -id CovDetail.1 -list {covergroup detail} { zero  max   }
gui_list_select -id CoverageTable.1 -list covtblFGroupsList { {$unit::counter_coverage::counter_cg.cx_en_count}  {$unit::counter_coverage::counter_cg.cp_enable}   }
gui_list_select -id CoverageTable.1 -list covtblFGroupsList { {$unit::counter_coverage::counter_cg.cp_enable}  {$unit::counter_coverage::counter_cg.cp_count}   }
verdiSetActWin -dock widgetDock_<Summary>
gui_list_select -id CoverageTable.1 -list covtblFGroupsList { {$unit::counter_coverage::counter_cg.cp_count}  {/$unit::counter_coverage::counter_cg}   }
gui_covtable_show -show  { Module List } -id  CoverageTable.1  -test  MergedTest
gui_covtable_show -show  { Function Groups } -id  CoverageTable.1  -test  MergedTest
gui_list_select -id CoverageTable.1 -list covtblFGroupsList { {/$unit::counter_coverage::counter_cg}   }
gui_covtable_show -show  { Module List } -id  CoverageTable.1  -test  MergedTest
gui_covtable_show -show  { Function Groups } -id  CoverageTable.1  -test  MergedTest
gui_covtable_show -show  { Module List } -id  CoverageTable.1  -test  MergedTest
gui_list_select -id CoverageTable.1 -list covtblModulesList { /uvm_pkg   } -type { Module  }
gui_list_expand -id  CoverageTable.1   -list {covtblModulesList} /uvm_pkg
gui_list_expand -id CoverageTable.1   /uvm_pkg
gui_list_action -id  CoverageTable.1 -list {covtblModulesList} /uvm_pkg  -type {Module}  -column {} 
gui_covtable_show -show  { Statistics } -id  CoverageTable.1  -test  MergedTest
gui_list_expand -id  CoverageTable.1   -list {covtblStatModuleList} Assert
gui_list_expand -id  CoverageTable.1   -list {covtblStatAssertDefList} Assertion
gui_list_expand -id  CoverageTable.1   -list {covtblStatAssertDefList} {Cover Property}
gui_list_expand -id  CoverageTable.1   -list {covtblStatAssertDefList} {Cover Sequence}
gui_list_expand -id  CoverageTable.1   -list {covtblStatAssertDefList} Total
gui_covtable_show -show  { Tests } -id  CoverageTable.1  -test  MergedTest
gui_list_select -id CoverageTable.1 -list covtblTestSummaryList { coverage/sim1   }
gui_list_select -id CoverageTable.1 -list covtblTestDetailList { rss_memory   }
gui_list_select -id CoverageTable.1 -list covtblTestSummaryList { coverage/sim1   }
gui_covtable_show -show  { Function Groups } -id  CoverageTable.1  -test  MergedTest
gui_list_select -id CoverageTable.1 -list covtblFGroupsList { {$unit::counter_coverage::counter_cg.cx_en_count}   }
gui_list_select -id CoverageTable.1 -list covtblFGroupsList { {$unit::counter_coverage::counter_cg.cx_en_count}  {$unit::counter_coverage::counter_cg.cx_rst_en}   }
gui_list_select -id CoverageTable.1 -list covtblFGroupsList { {$unit::counter_coverage::counter_cg.cx_rst_en}  {$unit::counter_coverage::counter_cg.cx_en_count}   }
gui_list_action -id  CoverageTable.1 -list {covtblFGroupsList} {$unit::counter_coverage::counter_cg.cx_en_count}  -column {Group} 
gui_list_select -id CovDetail.1 -list {covergroup detail} { {{[on],[max]}}   }
verdiSetActWin -dock widgetDock_<CovDetail>
verdiWindowResize -win $_vdCoverage_1 -731 "208" "1551" "1005"
gui_list_select -id CoverageTable.1 -list covtblFGroupsList { {$unit::counter_coverage::counter_cg.cx_en_count}  {$unit::counter_coverage::counter_cg.cp_count}   }
verdiSetActWin -dock widgetDock_<Summary>
gui_list_action -id  CoverageTable.1 -list {covtblFGroupsList} {$unit::counter_coverage::counter_cg.cp_count}  -column {Group} 
gui_list_select -id CoverageTable.1 -list covtblFGroupsList { {$unit::counter_coverage::counter_cg.cp_count}   }
gui_covtable_show -show  { Asserts } -id  CoverageTable.1  -test  MergedTest
gui_covtable_show -show  { Function Groups } -id  CoverageTable.1  -test  MergedTest
gui_covtable_show -show  { Module List } -id  CoverageTable.1  -test  MergedTest
gui_covtable_show -show  { Design Hierarchy } -id  CoverageTable.1  -test  MergedTest
vdCovExit -noprompt
