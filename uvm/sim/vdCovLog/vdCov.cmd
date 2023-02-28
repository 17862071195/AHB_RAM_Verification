gui_exclusion -set_force true
gui_assert_mode -mode flat
gui_class_mode -mode hier
gui_excl_mgr_flat_list -on  0
gui_covdetail_select -id  CovDetail.1   -name   Line
verdiWindowWorkMode -win $_vdCoverage_1 -coverageAnalysis
gui_open_cov  -hier out/cov.vdb -testdir {} -test {out/cov/ahb_ram_diff_haddr_test_0228215915 out/cov/ahb_ram_diff_haddr_test_0228220122 out/cov/ahb_ram_diff_haddr_test_0228220319} -merge MergedTest -db_max_tests 10 -fsm transition
gui_covtable_show -show  { Function Groups } -id  CoverageTable.1  -test  MergedTest
gui_list_expand -id  CoverageTable.1   -list {covtblFGroupsList} /ahb_ram_pkg::ahb_ram_cov::ahb_ram_address_cg
gui_list_expand -id  CoverageTable.1   -list {covtblFGroupsList} /ahb_ram_pkg::ahb_ram_cov::ahb_ram_address_cg
gui_list_expand -id  CoverageTable.1   -list {covtblFGroupsList} /ahb_ram_pkg::ahb_ram_cov::ahb_ram_type_size_cg
gui_list_select -id CoverageTable.1 -list covtblFGroupsList { ahb_ram_pkg::ahb_ram_cov::ahb_ram_type_size_cg.BURST_SIZE   }
gui_list_select -id CoverageTable.1 -list covtblFGroupsList { ahb_ram_pkg::ahb_ram_cov::ahb_ram_type_size_cg.BURST_SIZE  /ahb_ram_pkg::ahb_ram_cov::ahb_ram_type_size_cg   }
gui_list_select -id CoverageTable.1 -list covtblFGroupsList { /ahb_ram_pkg::ahb_ram_cov::ahb_ram_type_size_cg  ahb_ram_pkg::ahb_ram_cov::ahb_ram_type_size_cg.BURST_SIZE   }
gui_list_select -id CoverageTable.1 -list covtblFGroupsList { ahb_ram_pkg::ahb_ram_cov::ahb_ram_type_size_cg.BURST_SIZE  /ahb_ram_pkg::ahb_ram_cov::ahb_ram_type_size_cg   }
gui_list_action -id  CoverageTable.1 -list {covtblFGroupsList} /ahb_ram_pkg::ahb_ram_cov::ahb_ram_type_size_cg  -column {Group} 
gui_list_select -id CovDetail.1 -list covergroup { ahb_ram_pkg::ahb_ram_cov::ahb_ram_type_size_cg.BURST_SIZE  ahb_ram_pkg::ahb_ram_cov::ahb_ram_type_size_cg.BURST_TYPE   } -type { {Cover Group} {Cover Group}  }
gui_list_select -id CovDetail.1 -list covergroup { ahb_ram_pkg::ahb_ram_cov::ahb_ram_type_size_cg.BURST_TYPE  ahb_ram_pkg::ahb_ram_cov::ahb_ram_type_size_cg.BURST_SIZE   } -type { {Cover Group} {Cover Group}  }
gui_list_select -id CoverageTable.1 -list covtblFGroupsList { /ahb_ram_pkg::ahb_ram_cov::ahb_ram_type_size_cg  ahb_ram_pkg::ahb_ram_cov::ahb_ram_type_size_cg.BURST_TYPE   }
gui_list_action -id  CoverageTable.1 -list {covtblFGroupsList} ahb_ram_pkg::ahb_ram_cov::ahb_ram_type_size_cg.BURST_TYPE  -column {Group} 
gui_list_select -id CoverageTable.1 -list covtblFGroupsList { ahb_ram_pkg::ahb_ram_cov::ahb_ram_type_size_cg.BURST_TYPE  ahb_ram_pkg::ahb_ram_cov::ahb_ram_type_size_cg.BURST_SIZE   }
gui_list_action -id  CoverageTable.1 -list {covtblFGroupsList} ahb_ram_pkg::ahb_ram_cov::ahb_ram_type_size_cg.BURST_SIZE  -column {Group} 
vdCovExit -noprompt
