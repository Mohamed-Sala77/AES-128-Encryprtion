    class my_sequence extends uvm_sequence;
    `uvm_object_utils(my_sequence)

    my_sequence_item items;
    int file_handle;

    function new(string name ="my_sequence");
        super.new(name);
    endfunction

    task  pre_body();
    items = my_sequence_item::type_id::create("items");
    endtask //

    task body();
    for ( int i=0 ;i<500 ;i++ ) begin
        
        
            start_item(items);

            assert(items.randomize()) else $display ("Error in randomizing");

            //$display("Sequence Item: %p", items.convert2string());

            file_handle = $fopen("inputs.txt", "w");
            $fwrite(file_handle, "%h \n %h", items.in, items.key);

            $fclose(file_handle);

            //- here the $system command is used to run the python script like you run in cmd exactly
            $system("python AES_model.py");
            
            finish_item(items);
    end
    endtask

endclass
        