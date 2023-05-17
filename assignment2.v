module VendingMachine (
  input wire clk,
  input wire reset,
  input wire coin5,
  input wire coin10,
  input wire productA_button,
  input wire productB_button,
  input wire productC_button,
  input wire productD_button,
  output reg dispense_productA,
  output reg dispense_productB,
  output reg dispense_productC,
  output reg dispense_productD,
  output reg change5,
  output reg change10
);

  // Internal signals
  reg [1:0] current_state;
  reg [1:0] selected_product;
  reg [3:0] products;
  reg [3:0] prices;
  reg [3:0] inserted_coins;
  reg [3:0] remaining_price;
  reg [1:0] change;

  // Constants for product costs
  localparam COST_A = 2'b00;  // Rs. 5
  localparam COST_B = 2'b01;  // Rs. 10
  localparam COST_C = 2'b10;  // Rs. 15
  localparam COST_D = 2'b11;  // Rs. 20

  // Constants for coin values
  localparam COIN_5 = 2'b00;  // Rs. 5
  localparam COIN_10 = 2'b01; // Rs. 10

  // State machine states
  localparam IDLE = 2'b00;
  localparam SELECT_PRODUCT = 2'b01;
  localparam INSERT_COINS = 2'b10;
  localparam DISPENSE_PRODUCT = 2'b11;

  // Initialize signals
  initial begin
    current_state = IDLE;
    selected_product = 2'b00;
    products = 4'b0000;
    prices = {COST_A, COST_B, COST_C, COST_D};
    inserted_coins = 4'b0000;
    remaining_price = 4'b0000;
    dispense_productA = 0;
    dispense_productB = 0;
    dispense_productC = 0;
    dispense_productD = 0;
    change5 = 0;
    change10 = 0;
  end

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      current_state <= IDLE;
      selected_product <= 2'b00;
      products <= 4'b0000;
      inserted_coins <= 4'b0000;
      remaining_price <= 4'b0000;
      dispense_productA <= 0;
      dispense_productB <= 0;
      dispense_productC <= 0;
      dispense_productD <= 0;
      change5 <= 0;
      change10 <= 0;
    end else begin
      case (current_state)
        IDLE: begin
          // Transition to SELECT_PRODUCT state if a product button is pressed
          if (productA_button)
            current_state <= SELECT_PRODUCT;
          else if (productB_button)
            current_state <= SELECT_PRODUCT;
          else if (productC_button)
            current_state <= SELECT_PRODUCT;
          else if (productD_button)
            current_state <= SELECT_PRODUCT;
        end

        SELECT_PRODUCT: begin
          // Transition to INSERT_COINS state after selecting a product
          case ({productA_button, productB_button, productC_button, productD_button})
            4'b0001: begin
              selected_product <= COST_A;
              current_state <= INSERT_COINS;
            end
            4'b0010: begin
              selected_product <= COST_B;
              current_state <= INSERT_COINS;
            end
            4'b0100: begin
              selected_product <= COST_C;
              current_state <= INSERT_COINS;
            end
            4'b1000: begin
              selected_product <= COST_D;
              current_state <= INSERT_COINS;
            end
          endcase
        end

        INSERT_COINS: begin
          // Transition to DISPENSE_PRODUCT state if the required coins are inserted
          remaining_price <= selected_product - inserted_coins;
          if (coin5 && inserted_coins < selected_product && remaining_price >= COIN_5)
            inserted_coins <= inserted_coins + COIN_5;
          else if (coin10 && inserted_coins < selected_product && remaining_price >= COIN_10)
            inserted_coins <= inserted_coins + COIN_10;

          if (inserted_coins >= selected_product)
            current_state <= DISPENSE_PRODUCT;
        end

        DISPENSE_PRODUCT: begin
          // Dispense the selected product and calculate change
          products[selected_product] <= products[selected_product] + 1;
          change <= inserted_coins - selected_product;

          // Update output signals
          case (selected_product)
            COST_A: dispense_productA <= 1;
            COST_B: dispense_productB <= 1;
            COST_C: dispense_productC <= 1;
            COST_D: dispense_productD <= 1;
          endcase

          // Calculate and update change outputs
          change5 <= (change >= COIN_5) ? 1 : 0;
          change10 <= (change >= COIN_10) ? 1 : 0;

          // Transition back to IDLE state
          current_state <= IDLE;
        end
      endcase
    end
  end
endmodule




module VendingMachine_TB;

  // Testbench inputs
  reg clk;
  reg reset;
  reg coin5;
  reg coin10;
  reg productA_button;
  reg productB_button;
  reg productC_button;
  reg productD_button;

  // Testbench outputs
  wire dispense_productA;
  wire dispense_productB;
  wire dispense_productC;
  wire dispense_productD;
  wire change5;
  wire change10;

  // Instantiate the VendingMachine module
  VendingMachine dut (
    .clk(clk),
    .reset(reset),
    .coin5(coin5),
    .coin10(coin10),
    .productA_button(productA_button),
    .productB_button(productB_button),
    .productC_button(productC_button),
    .productD_button(productD_button),
    .dispense_productA(dispense_productA),
    .dispense_productB(dispense_productB),
    .dispense_productC(dispense_productC),
    .dispense_productD(dispense_productD),
    .change5(change5),
    .change10(change10)
  );

  // Clock generation
  always #5 clk = ~clk;

  // Initialize inputs
  initial begin
    clk = 0;
    reset = 1;
    coin5 = 0;
    coin10 = 0;
    productA_button = 0;
    productB_button = 0;
    productC_button = 0;
    productD_button = 0;
    #10 reset = 0;
  end



  
  initial begin
    // Select product A
    #15 productA_button = 1;
    #10 productA_button = 0;
    // Insert 10 rupees
    #10 coin10 = 1;
    #10 coin10 = 0;
    // Check if product A is dispensed
    if (dispense_productA)
      $display("Product A dispensed successfully!");
    else
      $display("Failed to dispense Product A!");
    // Check if change of 5 rupees is given
    if (change5)
      $display("Change of 5 rupees given successfully!");
    else
      $display("Failed to give change of 5 rupees!");

    // Select product B
    #20 productB_button = 1;
    #10 productB_button = 0;
    // Insert 10 rupees
    #10 coin10 = 1;
    #10 coin10 = 0;
    // Check if product B is dispensed
    if (dispense_productB)
      $display("Product B dispensed successfully!");
    else
      $display("Failed to dispense Product B!");
    // Check if change of 0 rupees is given
    if (!change5 && !change10)
      $display("No change given successfully!");
    else
      $display("Change should not be given!");

    // End simulation
    #10 $finish;
  end

endmodule

