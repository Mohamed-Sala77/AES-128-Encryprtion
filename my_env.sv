    class my_env extends uvm_env ;
    `uvm_component_utils(my_env)

my_agent agent;
my_scoreboard scoreboard;
my_subscriber subscriber;
virtual intf1 intf;
    
function new(string name ="my_env" , uvm_component parent=null);
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

 function void my_env::build_phase(uvm_phase phase);
    super.build_phase(phase);

agent = my_agent::type_id::create("agent", this);
scoreboard = my_scoreboard::type_id::create("scoreboard", this);
subscriber = my_subscriber::type_id::create("subscriber", this);


 if (!uvm_config_db#(virtual intf1)::get(this,"", "my_inf", intf)) 
`uvm_fatal(get_full_name(), "Error in getting interface")

uvm_config_db#(virtual intf1)::set(this,"agent", "my_inf", intf);
        
endfunction //build_phase

 function void my_env::connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    agent.monitor.m_put_port.connect(scoreboard.m_put_imp);
    agent.monitor.m_put_port.connect(subscriber.analysis_export);

endfunction //connect_phase
/*----------------------------------------------------------------------------*/


/*  UVM Run Phases                                                            */
/*----------------------------------------------------------------------------*/

 task my_env::run_phase(uvm_phase phase);
    super.run_phase(phase);
endtask