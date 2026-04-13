`ifndef UART_TX_SEQ_ITEM_SV
`define UART_TX_SEQ_ITEM_SV

`include "uvm_macros.svh"
import uvm_pkg::*;

class uart_tx_seq_item extends uvm_sequence_item;
    logic            tx_start;
    rand logic [7:0] tx_data;
    logic            uart_tx;
    logic            tx_busy;
    logic            tx_done;
    
    `uvm_object_utils_begin(uart_tx_seq_item)
        `uvm_field_int(tx_start, UVM_ALL_ON)
        `uvm_field_int(tx_data, UVM_ALL_ON)
        `uvm_field_int(uart_tx, UVM_ALL_ON)
        `uvm_field_int(tx_busy, UVM_ALL_ON)
        `uvm_field_int(tx_done, UVM_ALL_ON)
    `uvm_object_utils_end
    
    function new(string name = "uart_tx_seq_item");
        super.new(name); 
    endfunction //new()

    function string convert2string();
       return $sformatf("tx_start=%0b tx_data=%02h tx_busy=%0b tx_done=%0b", tx_start, tx_data, tx_busy, tx_done); 
    endfunction

endclass //component 
`endif