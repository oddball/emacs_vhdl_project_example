architecture rtl of block_a is

begin

  
  i_block_aa_1: block_aa
    port map (
      rstn => rstn,
      clk  => clk);

  i_block_aa_2: block_aa
    port map (
      rstn => rstn,
      clk  => clk);


end architecture rtl;
