architecture rtl of block_b is

begin

  i_block_bb_1: block_bb
    port map (
      rstn => rstn,
      clk  => clk);

  i_block_bb_2: block_bb
    port map (
      rstn => rstn,
      clk  => clk);

end architecture rtl;
