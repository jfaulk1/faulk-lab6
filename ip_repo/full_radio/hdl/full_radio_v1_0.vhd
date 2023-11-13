library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity full_radio_v1_0 is
	generic (
		-- Users to add parameters here

		-- User parameters ends
		-- Do not modify the parameters beyond this line


		-- Parameters of Axi Slave Bus Interface S00_AXI
		C_S00_AXI_DATA_WIDTH	: integer	:= 32;
		C_S00_AXI_ADDR_WIDTH	: integer	:= 4
	);
	port (
		-- Users to add ports here
        m_axis_tvalid : out std_logic;
        m_axis_tdata : out std_logic_vector(31 downto 0);
		-- User ports ends
		-- Do not modify the ports beyond this line


		-- Ports of Axi Slave Bus Interface S00_AXI
		s00_axi_aclk	: in std_logic;
		s00_axi_aresetn	: in std_logic;
		s00_axi_awaddr	: in std_logic_vector(C_S00_AXI_ADDR_WIDTH-1 downto 0);
		s00_axi_awprot	: in std_logic_vector(2 downto 0);
		s00_axi_awvalid	: in std_logic;
		s00_axi_awready	: out std_logic;
		s00_axi_wdata	: in std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
		s00_axi_wstrb	: in std_logic_vector((C_S00_AXI_DATA_WIDTH/8)-1 downto 0);
		s00_axi_wvalid	: in std_logic;
		s00_axi_wready	: out std_logic;
		s00_axi_bresp	: out std_logic_vector(1 downto 0);
		s00_axi_bvalid	: out std_logic;
		s00_axi_bready	: in std_logic;
		s00_axi_araddr	: in std_logic_vector(C_S00_AXI_ADDR_WIDTH-1 downto 0);
		s00_axi_arprot	: in std_logic_vector(2 downto 0);
		s00_axi_arvalid	: in std_logic;
		s00_axi_arready	: out std_logic;
		s00_axi_rdata	: out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
		s00_axi_rresp	: out std_logic_vector(1 downto 0);
		s00_axi_rvalid	: out std_logic;
		s00_axi_rready	: in std_logic
	);
end full_radio_v1_0;

architecture arch_imp of full_radio_v1_0 is
    
    --signal declarations 
    signal adc_out_i  : std_logic_vector(15 downto 0); 
    --signal fir1_out_i : std_logic_vector(15 downto 0); 
    signal adc_out_tvalid_i : std_logic; 
    --signal fir1_out_tvalid_i : std_logic; 
    --signal fir2_out_tvalid_i : std_logic;
    --signal fir2_out_i : std_logic_vector(23 downto 0); 
    signal fir2_real_bit : std_logic_vector(15 downto 0); 
    signal fir2_imaginary_bit : std_logic_vector(15 downto 0); 
    signal dacif_in_i : std_logic_vector(31 downto 0); 
    signal tuner_out_i : std_logic_vector(31 downto 0); 
    signal tuner_out_tvalid_i : std_logic;
    signal tuner_out_tdata_i : std_logic_vector(31 downto 0); 
    signal tuner_out_phase_tvalid_i : std_logic;
    signal tuner_out_phase_tdata_i : std_logic_vector(31 downto 0); 
    signal mult_out_tdata_i : std_logic_vector(31 downto 0);
    signal mult_out_tvalid_i : std_logic; 
    signal fir1_in_real_i : std_logic_vector(15 downto 0);
    signal fir1_in_imaginary_i : std_logic_vector(15 downto 0);
    signal fir1_out_real_tvalid_i : std_logic; 
    signal fir1_out_imaginary_tvalid_i : std_logic; 
    signal fir2_out_real_tvalid_i : std_logic; 
    signal fir2_out_imaginary_tvalid_i : std_logic; 
    signal fir1_out_real_i : std_logic_vector(15 downto 0); 
    signal fir1_out_imaginary_i : std_logic_vector(15 downto 0); 
    signal fir2_out_real_i : std_logic_vector(23 downto 0); 
    signal fir2_out_imaginary_i : std_logic_vector(23 downto 0); 
    
	-- component declaration
	component full_radio_v1_0_S00_AXI is
		generic (
		C_S_AXI_DATA_WIDTH	: integer	:= 32;
		C_S_AXI_ADDR_WIDTH	: integer	:= 4
		);
		port (
		m_axis_tvalid : out std_logic;
		m_axis_tdata : out std_logic_Vector(31 downto 0);
		S_AXI_ACLK	: in std_logic;
		S_AXI_ARESETN	: in std_logic;
		S_AXI_AWADDR	: in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		S_AXI_AWPROT	: in std_logic_vector(2 downto 0);
		S_AXI_AWVALID	: in std_logic;
		S_AXI_AWREADY	: out std_logic;
		S_AXI_WDATA	: in std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		S_AXI_WSTRB	: in std_logic_vector((C_S_AXI_DATA_WIDTH/8)-1 downto 0);
		S_AXI_WVALID	: in std_logic;
		S_AXI_WREADY	: out std_logic;
		S_AXI_BRESP	: out std_logic_vector(1 downto 0);
		S_AXI_BVALID	: out std_logic;
		S_AXI_BREADY	: in std_logic;
		S_AXI_ARADDR	: in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		S_AXI_ARPROT	: in std_logic_vector(2 downto 0);
		S_AXI_ARVALID	: in std_logic;
		S_AXI_ARREADY	: out std_logic;
		S_AXI_RDATA	: out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		S_AXI_RRESP	: out std_logic_vector(1 downto 0);
		S_AXI_RVALID	: out std_logic;
		S_AXI_RREADY	: in std_logic;
		ADC_OUT         : out std_logic_vector(15 downto 0); --this is what will be passed to FIR1 
		ADC_OUT_TVALID  : out std_logic;
		DACIF_IN        : in std_logic_vector(31 downto 0); --receive dacif data from this file, pass it into AXI stream, assign to sig and pass back out ? 
		TUNER_OUT       : out std_logic_vector(31 downto 0)
		);
	end component full_radio_v1_0_S00_AXI;

COMPONENT fir_compiler_0
  PORT (
    aclk : IN STD_LOGIC;
    s_axis_data_tvalid : IN STD_LOGIC;
    s_axis_data_tready : OUT STD_LOGIC;
    s_axis_data_tdata : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    m_axis_data_tvalid : OUT STD_LOGIC;
    m_axis_data_tdata : OUT STD_LOGIC_VECTOR(15 DOWNTO 0) 
  );
END COMPONENT;

COMPONENT fir_compiler_2
  PORT (
    aclk : IN STD_LOGIC;
    s_axis_data_tvalid : IN STD_LOGIC;
    s_axis_data_tready : OUT STD_LOGIC;
    s_axis_data_tdata : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    m_axis_data_tvalid : OUT STD_LOGIC;
    m_axis_data_tdata : OUT STD_LOGIC_VECTOR(23 DOWNTO 0) 
  );
END COMPONENT;

COMPONENT tuner_dds
  PORT (
    aclk : IN STD_LOGIC;
    aresetn : IN STD_LOGIC;
    s_axis_phase_tvalid : IN STD_LOGIC;
    s_axis_phase_tdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    m_axis_data_tvalid : OUT STD_LOGIC;
    m_axis_data_tdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    m_axis_phase_tvalid : OUT STD_LOGIC;
    m_axis_phase_tdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0) 
  );
END COMPONENT;

COMPONENT complex_multiplier
  PORT (
    aclk : IN STD_LOGIC;
    s_axis_a_tvalid : IN STD_LOGIC;
    s_axis_a_tdata : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    s_axis_b_tvalid : IN STD_LOGIC;
    s_axis_b_tdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    m_axis_dout_tvalid : OUT STD_LOGIC;
    m_axis_dout_tdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0) 
  );
END COMPONENT;

begin

-- Instantiation of Axi Bus Interface S00_AXI
full_radio_v1_0_S00_AXI_inst : full_radio_v1_0_S00_AXI
	generic map (
		C_S_AXI_DATA_WIDTH	=> C_S00_AXI_DATA_WIDTH,
		C_S_AXI_ADDR_WIDTH	=> C_S00_AXI_ADDR_WIDTH
	)
	port map (
	    m_axis_tdata => m_axis_tdata,
        m_axis_tvalid => m_axis_tvalid,
		S_AXI_ACLK	=> s00_axi_aclk,
		S_AXI_ARESETN	=> s00_axi_aresetn,
		S_AXI_AWADDR	=> s00_axi_awaddr,
		S_AXI_AWPROT	=> s00_axi_awprot,
		S_AXI_AWVALID	=> s00_axi_awvalid,
		S_AXI_AWREADY	=> s00_axi_awready,
		S_AXI_WDATA	=> s00_axi_wdata,
		S_AXI_WSTRB	=> s00_axi_wstrb,
		S_AXI_WVALID	=> s00_axi_wvalid,
		S_AXI_WREADY	=> s00_axi_wready,
		S_AXI_BRESP	=> s00_axi_bresp,
		S_AXI_BVALID	=> s00_axi_bvalid,
		S_AXI_BREADY	=> s00_axi_bready,
		S_AXI_ARADDR	=> s00_axi_araddr,
		S_AXI_ARPROT	=> s00_axi_arprot,
		S_AXI_ARVALID	=> s00_axi_arvalid,
		S_AXI_ARREADY	=> s00_axi_arready,
		S_AXI_RDATA	=> s00_axi_rdata,
		S_AXI_RRESP	=> s00_axi_rresp,
		S_AXI_RVALID	=> s00_axi_rvalid,
		S_AXI_RREADY	=> s00_axi_rready,
		ADC_OUT         => adc_out_i,
		ADC_OUT_TVALID  => adc_out_tvalid_i, 
		DACIF_IN        => dacif_in_i,
		TUNER_OUT       => tuner_out_i  
	);

	-- Add user logic here

filter1_real : fir_compiler_0
  PORT MAP (
    aclk => s00_axi_aclk,
    s_axis_data_tvalid => '1', --change
    s_axis_data_tready => open,
    s_axis_data_tdata => fir1_in_real_i,
    m_axis_data_tvalid => fir1_out_real_tvalid_i,
    m_axis_data_tdata => fir1_out_real_i
  );
  
  filter1_imaginary : fir_compiler_0
  PORT MAP (
    aclk => s00_axi_aclk,
    s_axis_data_tvalid => '1', 
    s_axis_data_tready => open,
    s_axis_data_tdata => fir1_in_imaginary_i,
    m_axis_data_tvalid => fir1_out_imaginary_tvalid_i,
    m_axis_data_tdata => fir1_out_imaginary_i
  );
   
   filter2_real : fir_compiler_2
  PORT MAP (
    aclk => s00_axi_aclk,
    s_axis_data_tvalid => '1',
    s_axis_data_tready => open,
    s_axis_data_tdata => fir1_out_real_i,
    m_axis_data_tvalid => fir2_out_real_tvalid_i,
    m_axis_data_tdata => fir2_out_real_i
  );
  
  filter2_imaginary : fir_compiler_2
  PORT MAP (
    aclk => s00_axi_aclk,
    s_axis_data_tvalid => fir1_out_imaginary_tvalid_i,
    s_axis_data_tready => open,
    s_axis_data_tdata => fir1_out_imaginary_i,
    m_axis_data_tvalid => fir2_out_imaginary_tvalid_i,
    m_axis_data_tdata => fir2_out_imaginary_i
  );
  
  tuner : tuner_dds
  PORT MAP (
    aclk => s00_axi_aclk,
    aresetn => s00_axi_aresetn,
    s_axis_phase_tvalid => '1',
    s_axis_phase_tdata => tuner_out_i,
    m_axis_data_tvalid => tuner_out_tvalid_i,
    m_axis_data_tdata => tuner_out_tdata_i,
    m_axis_phase_tvalid => tuner_out_phase_tvalid_i,
    m_axis_phase_tdata => tuner_out_phase_tdata_i 
  );
  
  multiply : complex_multiplier
  PORT MAP (
    aclk => s00_axi_aclk,
    s_axis_a_tvalid => adc_out_tvalid_i,
    s_axis_a_tdata => adc_out_i,
    s_axis_b_tvalid => tuner_out_phase_tvalid_i,
    s_axis_b_tdata => tuner_out_tdata_i,
    m_axis_dout_tvalid => mult_out_tvalid_i,
    m_axis_dout_tdata => mult_out_tdata_i
  );
  
  fir1_in_real_i <= mult_out_tdata_i(15 downto 0); 
  fir1_in_imaginary_i <= mult_out_tdata_i(31 downto 16);
 
  fir2_imaginary_bit <= fir2_out_imaginary_i(15 downto 0);
  fir2_real_bit <= fir2_out_real_i(15 downto 0);
  dacif_in_i <= fir2_imaginary_bit & fir2_real_bit; 
  
	-- User logic ends

end arch_imp;
