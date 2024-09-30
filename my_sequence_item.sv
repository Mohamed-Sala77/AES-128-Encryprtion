    class my_sequence_item extends uvm_sequence_item;
    `uvm_object_utils(my_sequence_item)
    function new(string name ="my_sequence_item");
        super.new(name);
    endfunction

    rand bit [127:0]  in ;
    rand bit [127:0]  key;
    bit [127:0]  out;


    virtual function string convert2string();
        return $sformatf("\nTransaction:\tin = %0h   ,\tkey = %0h   ,\tout = %0h\n", 
            in, key, out);
    endfunction
endclass
        