library verilog;
use verilog.vl_types.all;
entity sr_9bit is
    port(
        clk             : in     vl_logic;
        n_rst           : in     vl_logic;
        serial_in       : in     vl_logic;
        shift_strobe    : in     vl_logic;
        packet_data     : out    vl_logic_vector(7 downto 0);
        stop_bit        : out    vl_logic
    );
end sr_9bit;
