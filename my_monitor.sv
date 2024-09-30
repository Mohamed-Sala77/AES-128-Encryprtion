    class  my_monitor  extends uvm_monitor ;
    `uvm_component_utils( my_monitor )

 my_sequence_item  sequence_item;
 virtual intf1 intf;
 uvm_analysis_port#(my_sequence_item) m_put_port;

    
function new(string name =" my_monitor " , uvm_component parent=null);
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

 function void  my_monitor ::build_phase(uvm_phase phase);
    super.build_phase(phase);
 sequence_item =  my_sequence_item::type_id::create("sequence_item", this);
 if (!uvm_config_db#(virtual intf1)::get(this,"", "my_inf", intf)) 
`uvm_fatal(get_full_name(), "Error in getting interface")

 m_put_port = new("m_put_port", this);
        
endfunction //build_phase

 function void  my_monitor ::connect_phase(uvm_phase phase);
    super.connect_phase(phase);
endfunction //connect_phase
/*----------------------------------------------------------------------------*/


/*  UVM Run Phases                                                            */
/*----------------------------------------------------------------------------*/

 task  my_monitor ::run_phase(uvm_phase phase);
    super.run_phase(phase);
    #5;
    forever begin
        
        sequence_item.in= intf.in ;
        sequence_item.out= intf.out ;
        sequence_item.key= intf.key ;

        //$display("---------------------------------------------------------------");
        //$display(" TRANSACTION RECEIVED IN Monitor IS %p at %t" ,sequence_item.convert2string() , $realtime);
        //$display("---------------------------------------------------------------");

        m_put_port.write(sequence_item);

        #10;
    end
endtask