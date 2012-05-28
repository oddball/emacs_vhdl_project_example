architecture rtl of top is

begin

  i_block_a: block_a
    port map (
      rstn => rstn,
      clk  => clk);

  i_block_b: block_b
    port map (
      rstn => rstn,
      clk  => clk);
  

end architecture rtl;
