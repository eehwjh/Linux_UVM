`ifndef UART_TX_DRIVER_SV
`define UART_TX_DRIVER_SV

`include "uvm_macros.svh"
import uvm_pkg::*;
`include "uart_tx_seq_item.sv"

class uart_tx_driver extends uvm_driver #(uart_tx_seq_item);
    `uvm_component_utils(uart_tx_driver)
    virtual uart_if vif;
    
    function new(string name, uvm_component parent);
        super.new(name, parent); 
    endfunction //new()

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db#(virtual uart_if)::get(this, "", "vif", vif)) begin
            `uvm_fatal(get_type_name(), "uart_tx_driver에서 uvm_config_db 에러 발생.");
        end

    endfunction

    virtual task run_phase(uvm_phase phase);
        uart_tx_bus_init();
        wait(vif.rst == 1'b0);
        `uvm_info(get_type_name(), "리셋 해제 확인. 트랜잭션 대기 중...", UVM_MEDIUM)
        
        forever begin
            uart_tx_seq_item tx;
            seq_item_port.get_next_item(tx);
            drive_uart_tx(tx);
            seq_item_port.item_done();
        end
    
    endtask //

    task uart_tx_bus_init();
        vif.tx_drv_cb.tx_start <= 0;
        vif.tx_drv_cb.tx_data <=0;
    endtask

    task drive_uart_tx(uart_tx_seq_item tx);
        @(vif.tx_drv_cb);
        vif.tx_drv_cb.tx_data <= tx.tx_data;
        vif.tx_drv_cb.tx_start <= 1'b1;

        @(vif.tx_drv_cb);
        vif.tx_drv_cb.tx_start <= 1'b0;

        wait(vif.tx_drv_cb.tx_done == 1'b1);
        `uvm_info(get_type_name(), $sformatf("TX Driver 구동 완료: %s", tx.convert2string()), UVM_MEDIUM)

    endtask //
endclass //component 
`endif