class Stenomancer < Gosu::Window
  def initialize
    super 800, 600
    # you can optionally set fullscreen
    # super(800, 600, :fullscreen => true)
    self.caption = "Stenomancer"
    @background_image = Gosu::Image.new("media/stone_floor.png", :tileable => true)
    @player = Player.new(@background_image, 100, 100)
  end

  def update
  
  end

  def draw
    @background_image.draw(0, 0, 0)
    @player.draw
  end
end
