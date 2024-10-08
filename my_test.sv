    class  my_test extends uvm_test ;
    `uvm_component_utils( my_test)

my_env env;
my_sequence sequences;
virtual intf1 intf;
    
function new(string name =" my_test" , uvm_component parent=null);
        super.new(name , parent);
    endfunction


/*---  UVM Build Phases            ---*/
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

 function void  my_test::build_phase(uvm_phase phase);
    super.build_phase(phase);

env = my_env::type_id::create("env", this);
sequences = my_sequence::type_id::create("sequences", this);


 if (!uvm_config_db#(virtual intf1)::get(this,"", "my_inf", intf)) 
`uvm_fatal(get_full_name(), "Error in getting interface")

uvm_config_db#(virtual intf1)::set(this,"env", "my_inf", intf);
        
endfunction //build_phase

 function void  my_test::connect_phase(uvm_phase phase);
    super.connect_phase(phase);
endfunction //connect_phase
/*----------------------------------------------------------------------------*/


/*  UVM Run Phases                                                            */
/*----------------------------------------------------------------------------*/

 task  my_test::run_phase(uvm_phase phase);
 super.run_phase(phase);

 phase.raise_objection(this,"Starting Sequences");
  sequences.start(env.agent.sequencer);
  phase.drop_objection(this,"Ending Sequences");

endtask