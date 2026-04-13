`ifndef UART_TX_MONITOR_SV
`define UART_TX_MONITOR_SV

`include "uvm_macros.svh"
import uvm_pkg::*;

class uart_tx_monitor extends uvm_monitor;
    `uvm_component_utils(uart_tx_monitor)
    uvm_analysis_port #(uart_tx_seq_item) ap;
    virtual uart_if vif;

    logic [7:0] ref_tx_data [0:3];
    parameter BAUD = 9600 * 16;
    parameter BAUD_PERIOD = (100_000_000/BAUD) * 10;
    integer i, j;
    
    function new(string name, uvm_component parent);
        super.new(name, parent); 
    endfunction //new()

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        ap = new("ap", this);
        if (!uvm_config_db#(virtual uart_if)::get(this,"", "vif", vif)) begin
            `uvm_fatal(get_type_name(), "uart_tx_monitor에서 uvm_config_db 에러 발생.");
        end
    endfunction

    virtual task run_phase(uvm_phase phase);
        `uvm_info(get_type_name(), "UART_TX 버스 모니터링 시작...",UVM_MEDIUM)

        forever begin
            collect_transaction();
        end
    endtask //

    task collect_transaction();
        uart_tx_seq_item tx;
        tx = uart_tx_seq_item::type_id::create("tx");

        wait(vif.tx_mon_cb.tx_start == 1'b1);

        tx.tx_data = vif.tx_mon_cb.tx_data;

        wait(vif.tx_mon_cb.tx_done == 1'b1);

        ap.write(tx);
        `uvm_info(get_type_name(), $sformatf("TX Monitor 캡처 완료: %s", tx.convert2string()), UVM_MEDIUM)

    endtask //
endclass //component 
`endif