from PIL import Image, ImageDraw

def create_gem():
    # Create a 32x32 transparent image
    width = 32
    height = 32
    img = Image.new('RGBA', (width, height), (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)

    # Colors
    light_blue = (100, 200, 255, 255)
    dark_blue = (0, 100, 200, 255)
    white = (255, 255, 255, 255)
    outline = (0, 0, 50, 255)

    # Diamond shape points
    # Top center: 16, 4
    # Right: 28, 16
    # Bottom center: 16, 28
    # Left: 4, 16
    
    # Draw outline
    points = [(16, 4), (28, 16), (16, 28), (4, 16)]
    draw.polygon(points, fill=dark_blue, outline=outline)
    
    # Draw inner light part (top highlight)
    inner_points = [(16, 6), (24, 14), (16, 18), (8, 14)]
    draw.polygon(inner_points, fill=light_blue)
    
    # Draw simple highlight pixel
    draw.point((16, 6), fill=white)

    # Save
    path = "/home/mladen/Unreal/Godot/Projects/MonsterChromatic/assets/pickups/blue_gem.png"
    img.save(path, "PNG")
    print(f"Generated clean PNG at {path}")

if __name__ == "__main__":
    create_gem()
