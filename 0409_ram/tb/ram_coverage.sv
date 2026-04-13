`ifndef RAM_COVERAGE_SV
`define RAM_COVERAGE_SV

`include "uvm_macros.svh"
import uvm_pkg::*;
`include "ram_seq_item.sv"

class ram_coverage extends uvm_subscriber#(ram_seq_item);
    `uvm_component_utils(ram_coverage)

    ram_seq_item item;

    covergroup ram_cg;
        cp_wr: coverpoint item.wr {bins write = {1}; bins read = {0};}
        cp_wr_write: coverpoint item.wr {bins write_only = {1};}
        cp_wr_read: coverpoint item.wr {bins read_only = {0};} 
        cp_addr: coverpoint item.addr {bins zero = {0}; bins low = {[1:127]}; bins high = {[128:254]}; bins max = {255};}
        cp_wdata: coverpoint item.wdata {bins zero = {0}; bins low = {[1:32768]}; bins high = {[32769:65534]}; bins max = {65535};}
        cp_rdata: coverpoint item.rdata {bins zero = {0}; bins low = {[1:32768]}; bins high = {[32769:65534]}; bins max = {65535};}
        // cross coverage
        cx_write: cross cp_wr_write, cp_addr, cp_wdata;
        cx_read: cross cp_wr_read, cp_addr, cp_rdata; 
    endgroup
    
    function new(string name, uvm_component parent);
        super.new(name, parent); 
        ram_cg = new();
    endfunction //new()

    virtual function void write(ram_seq_item t);
        item = t;
        ram_cg.sample();
        `uvm_info(get_type_name(), $sformatf("ram_cg sampled: %s", item.convert2string()), UVM_MEDIUM)
    endfunction

    virtual function void report_phase(uvm_phase phase);
        `uvm_info(get_type_name(), " \n\n===== Coverage Summary =====", UVM_LOW);
        `uvm_info(get_type_name(), $sformatf("  Overall: %.1f%%", ram_cg.get_coverage()), UVM_LOW);
        `uvm_info(get_type_name(), $sformatf("  wr     : %.1f%%", ram_cg.cp_wr.get_coverage()), UVM_LOW);
        `uvm_info(get_type_name(), $sformatf("  addr   : %.1f%%", ram_cg.cp_addr.get_coverage()), UVM_LOW);
        `uvm_info(get_type_name(), $sformatf("  wdata  : %.1f%%", ram_cg.cp_wdata.get_coverage()), UVM_LOW);
        `uvm_info(get_type_name(), $sformatf("  rdata  : %.1f%%", ram_cg.cp_rdata.get_coverage()), UVM_LOW); 
        `uvm_info(get_type_name(), $sformatf("  cross(write) : %.1f%%", ram_cg.cx_write.get_coverage()), UVM_LOW); 
        `uvm_info(get_type_name(), $sformatf("  cross(read)  : %.1f%%", ram_cg.cx_read.get_coverage()), UVM_LOW); 
        `uvm_info(get_type_name(), "===== Coverage Summary =====\n\n", UVM_LOW);
    endfunction
endclass //component 



`endif