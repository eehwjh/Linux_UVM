`ifndef UART_RX_SEQ_ITEM_SV
`define UART_RX_SEQ_ITEM_SV

`include "uvm_macros.svh"
import uvm_pkg::*;

class uart_rx_seq_item extends uvm_sequence_item;
    logic            uart_rx;
    rand logic [7:0] rx_data;
    logic            rx_done;
    
    `uvm_object_utils_begin(uart_rx_seq_item)
        `uvm_field_int(uart_rx, UVM_ALL_ON)
        `uvm_field_int(rx_data, UVM_ALL_ON)
        `uvm_field_int(rx_done, UVM_ALL_ON)
    `uvm_object_utils_end
    
    function new(string name = "uart_rx_seq_item");
        super.new(name); 
    endfunction //new()

    function string convert2string();
       return $sformatf("rx_data=%02h rx_done=%0b", rx_data, rx_done); 
    endfunction

endclass //component 
`endif