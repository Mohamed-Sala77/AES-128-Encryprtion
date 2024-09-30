    class my_driver  extends uvm_driver   #(my_sequence_item);
    `uvm_component_utils(my_driver )

my_sequence_item sequence_item;
virtual intf1 intf;
    
function new(string name ="my_driver " , uvm_component parent=null);
        super.new(name , parent);
    endfunction



/*---  UVM Build Phases---*/
/*------------------------------------*/
//  Function: build_phase
extern function void build_phase(uvm_phase phase);
//  Function: connect_phase
extern function void connect_phase(uvm_phase phase);

/*---  UVM Run Phases              ---*/
/*------------------------------------*/
//  Function: run_phase
extern task run_phase(uvm_phase phase);
endclass




/*----------------------------------------------------------------------------*/


/*  UVM Build Phases                                                          */
/*----------------------------------------------------------------------------*/

 function void my_driver::build_phase(uvm_phase phase);
    super.build_phase(phase);
sequence_item   = my_sequence_item::type_id::create("sequence_item", this);

 
 if (!uvm_config_db#(virtual intf1)::get(this,"","my_inf",intf))
 `uvm_fatal(get_full_name(), "Error in getting interface")  

        
endfunction //build_phase

 function void my_driver::connect_phase(uvm_phase phase);
    super.connect_phase(phase);
endfunction //connect_phase


/*----------------------------------------------------------------------------*/
/*  UVM Run Phases                                                            */
/*----------------------------------------------------------------------------*/

 task my_driver::run_phase(uvm_phase phase);
    super.run_phase(phase);
    forever begin
        seq_item_port.get_next_item(sequence_item);
        
        //$display("---------------------------------------------------------------");
        //$display(" TRANSACTION RECEIVED IN DRIVER IS %p",sequence_item.convert2string());
        //$display("---------------------------------------------------------------");
        intf.in  <= sequence_item.in ;
        intf.key <= sequence_item.key ;

        #10;
        seq_item_port.item_done();
    end
endtask

