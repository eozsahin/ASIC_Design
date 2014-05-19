library verilog;
use verilog.vl_types.all;
entity timer is
    port(
        clk             : in     vl_logic;
        n_rst           : in     vl_logic;
        enable_timer    : in     vl_logic;
        shift_strobe    : out    vl_logic;
        packet_done     : out    vl_logic
    );
end timer;
