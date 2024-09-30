    class  my_subscriber   extends  uvm_subscriber #(my_sequence_item);
    `uvm_component_utils( my_subscriber  )

my_sequence_item sequence_item;



covergroup group_1;
Input_Data: coverpoint sequence_item.in {
    bins Input_Data[3] = {0 , 32'hFFFF_FFFF,[1:128'hFFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFE]};
}

Key: coverpoint sequence_item.key {
    bins key[3] = {0 , 32'hFFFF_FFFF,[1:128'hFFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFE]};
}

in_with_key: cross Input_Data,Key ;
endgroup


    
function new(string name =" my_subscriber  " , uvm_component parent=null);
        super.new(name , parent);
        group_1 = new();
    endfunction

 extern function void write (my_sequence_item t);


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

 function void my_subscriber   ::build_phase(uvm_phase phase);
    super.build_phase(phase);
sequence_item   = my_sequence_item::type_id::create("sequence_item",this);
endfunction //build_phase

 function void my_subscriber   ::connect_phase(uvm_phase phase);
    super.connect_phase(phase);
endfunction //connect_phase


/*----------------------------------------------------------------------------*/
/*  UVM Run Phases                                                            */
/*----------------------------------------------------------------------------*/

 task my_subscriber   ::run_phase(uvm_phase phase);
    super.run_phase(phase);
endtask

 function void my_subscriber::write(my_sequence_item t); 
 sequence_item = t;

 
//$display("---------------------------------------------------------------");
//$display(" TRANSACTION RECEIVED IN Subscriber IS %p",sequence_item.convert2string());
//$display("---------------------------------------------------------------");

group_1.sample();

 endfunction 