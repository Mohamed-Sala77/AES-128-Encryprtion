    class my_scoreboard extends uvm_scoreboard ;
    `uvm_component_utils(my_scoreboard)

 my_sequence_item  sequence_item;
 event run ;
    int file_handle;
    int count = 0;
    int pass_count = 0;
    int failed_count = 0;
    int non_count = 0;
    logic [127:0] expected_out;


 uvm_analysis_imp#(my_sequence_item, my_scoreboard) m_put_imp;


    
function new(string name ="my_scoreboard" , uvm_component parent=null);
        super.new(name , parent);
    endfunction


 extern function void write (my_sequence_item t);
 extern function void compare( my_sequence_item t);


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

extern function void report_phase(uvm_phase phase);
endclass




/*----------------------------------------------------------------------------*/


/*  UVM Build Phases                                                          */
/*----------------------------------------------------------------------------*/

 function void my_scoreboard::build_phase(uvm_phase phase);
    super.build_phase(phase);
sequence_item =  my_sequence_item::type_id::create("sequence_item", this);

m_put_imp = new("m_put_imp", this);
        
endfunction //build_phase

 function void my_scoreboard::connect_phase(uvm_phase phase);
    super.connect_phase(phase);
endfunction //connect_phase
/*----------------------------------------------------------------------------*/


/*  UVM Run Phases                                                            */
/*----------------------------------------------------------------------------*/

 task my_scoreboard::run_phase(uvm_phase phase);
    super.run_phase(phase);

    forever begin
        @(run);
        compare(sequence_item);

    end
endtask



function void my_scoreboard::write(my_sequence_item t); 
sequence_item = t;

//$display("---------------------------------------------------------------");
//$display(" TRANSACTION RECEIVED IN Scoreboard IS %p",sequence_item.convert2string());
//$display("---------------------------------------------------------------");

-> run;


endfunction 


function void my_scoreboard::compare(my_sequence_item t);
    file_handle = $fopen("output.txt","r");

    if ($fscanf(file_handle, "%h", expected_out) == 0) begin
        `uvm_error("COMPARE", $sformatf("Error: no output exist"))
        count++;
        non_count++;
    end
    else if (expected_out==t.out) begin
        //$display("operation ID:%4d, Passed Encryption:\n Expected_py: %h \n Checked:     %h", count, expected_out, t.out);
        //$display("-------------------------------");
        count++;
        pass_count++;
    end
    else if (expected_out!=t.out) begin
        `uvm_error("COMPARE", $sformatf( "operation ID:%4d, Failed Encryption:\n Expected_py: %h \n Checked:     %h", count, expected_out, t.out))

        //$display("-------------------------------");
        count++;
        failed_count++;
    end
    $fclose(file_handle);
    
endfunction

function void my_scoreboard::report_phase(uvm_phase phase);
super.report_phase(phase);
`uvm_info("report_phase", $sformatf("Total transactions: %0d", count), UVM_MEDIUM);
`uvm_info("report_phase", $sformatf("Total non transactions: %0d", non_count), UVM_MEDIUM);
`uvm_info("report_phase", $sformatf("Total successful transactions: %0d", pass_count), UVM_MEDIUM);
`uvm_info("report_phase", $sformatf("Total failed transactions: %0d", failed_count), UVM_MEDIUM);
endfunction // report_phas