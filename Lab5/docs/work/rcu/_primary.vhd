library verilog;
use verilog.vl_types.all;
entity rcu is
    port(
        clk             : in     vl_logic;
        n_rst           : in     vl_logic;
        start_bit_detected: in     vl_logic;
        packet_done     : in     vl_logic;
        framing_error   : in     vl_logic;
        sbc_clear       : out    vl_logic;
        sbc_enable      : out    vl_logic;
        load_buffer     : out    vl_logic;
        enable_timer    : out    vl_logic
    );
end rcu;
