from PIL import Image, ImageDraw

def process_gem():
    # We use the previously generated v3 image source if possible, or the current blue_gem if it has the background
    # Since I might have overwritten blue_gem with a "failed" transparency attempt, it's safer to re-process the source v3.
    src_path = "/home/mladen/.gemini/antigravity/brain/9daf3b84-9fda-4d15-85bc-f6e8ee97074d/chromatic_gem_v3_1765050441061.png"
    dst_path = "/home/mladen/Unreal/Godot/Projects/MonsterChromatic/assets/pickups/blue_gem.png"
    
    try:
        img = Image.open(src_path).convert("RGBA")
        
        # Method: Flood fill from corners with a tolerance
        # Since we don't have advanced floodfill in basic PIL without complex logic, 
        # we'll stick to a smarter color distance check but apply it carefully.
        
        # Actually, let's just do a purely distance based alpha.
        # Anything close to white becomes transparent.
        
        datas = img.getdata()
        new_data = []
        
        for item in datas:
            # item is (r, g, b, a)
            # Check distance from white
            # (255, 255, 255)
            
            # Simple Manhattan distance from white
            dist = (255 - item[0]) + (255 - item[1]) + (255 - item[2])
            
            # If it's very close to white (dist < 30), make it fully transparent
            if dist < 50:
                 new_data.append((255, 255, 255, 0))
            else:
                 new_data.append(item)
                 
        img.putdata(new_data)
        
        # Now do the resize logic again to keep aspect ratio
        final_img = Image.new("RGBA", (64, 64), (0, 0, 0, 0))
        img.thumbnail((64, 64), Image.Resampling.LANCZOS)
        
        # Center it
        x = (64 - img.width) // 2
        y = (64 - img.height) // 2
        
        final_img.paste(img, (x, y))
        
        final_img.save(dst_path, "PNG")
        print(f"Processed and saved to {dst_path}")
        
    except Exception as e:
        print(f"Error: {e}")

if __name__ == "__main__":
    process_gem()
