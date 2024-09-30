module my_top;
import uvm_pkg::*;
`include "pack1.sv";
intf1 intf () ;


AES_Encrypt dut1 (
    .in(intf.in),
    .key(intf.key),
    .out(intf.out)
);


initial
begin
    uvm_config_db#(virtual intf1)::set(null, "uvm_test_top", "my_inf", intf);
    run_test("my_test");
    end 
 endmodule  
