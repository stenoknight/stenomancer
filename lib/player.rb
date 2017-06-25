class Player
  attr_reader :x, :y

  def initialize(map, x, y)
    @image = Gosu::Image.new("media/walking_sprite.png")
    @x, @y = x, y
    @dire = :left
    @vy = 0 # Vertical velocity
    @map = map
    # Load all animation frames
    @walk1, @walk2, @walk3, @walk4, @walk5 = *Gosu::Image.load_tiles("media/walking_sprite.png", 75, 205)
    # This always points to the frame that is currently drawn.
    # This is set in update, and used in draw.
    @cur_image = @walk1
  end


  def draw
    # Flip vertically when facing to the left.
    if @dir == :left
      offs_x = -25
      factor = 1.0
    else
      offs_x = 25
      factor = -1.0
    end

    @cur_image.draw(@x + offs_x, @y - 49, 0, factor, 1.0)
  end

  # Could the object be placed at x + offs_x/y + offs_y without being stuck?
  def would_fit(offs_x, offs_y)
    # Check at the center/top and center/bottom for map collisions
    not @map.solid?(@x + offs_x, @y + offs_y) and
      not @map.solid?(@x + offs_x, @y + offs_y - 45)
    end

  def update(move_x)
    # Select image depending on action
    if (move_x == 0)
      @cur_image = @standing
    else
      @cur_image = (Gosu.milliseconds / 175 % 2 == 0) ? @walk1 : @walk2
    end
    if (@vy < 0)
      @cur_image = @jump
    end

    # Directional walking, horizontal movement
    if move_x > 0
      @dir = :right
      move_x.times { if would_fit(1, 0) then @x += 1 end}
    end
    if move_x < 0
      @dir = :left
      (-move.x).times { if would_fit(-1, 0) then @x -= 1 end}
    end
  end
end

