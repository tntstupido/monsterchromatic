from PIL import Image

def process_gem():
    src_path = "/home/mladen/.gemini/antigravity/brain/9daf3b84-9fda-4d15-85bc-f6e8ee97074d/chromatic_gem_v3_1765050441061.png" # Updated timestamp
    dst_path = "/home/mladen/Unreal/Godot/Projects/MonsterChromatic/assets/pickups/blue_gem.png"
    
    try:
        img = Image.open(src_path).convert("RGBA")
        datas = img.getdata()
        
        new_data = []
        for item in datas:
            # Remove white background / shadows
            # aggressive white removal
            if item[0] > 220 and item[1] > 220 and item[2] > 220:
                new_data.append((255, 255, 255, 0))
            else:
                new_data.append(item)
                
        img.putdata(new_data)
        
        # Crop tight bounding box
        bbox = img.getbbox()
        if bbox:
            img = img.crop(bbox)
            
        # Resize to fit within 64x64 without stretching
        # Create a new blank 64x64 image
        final_img = Image.new("RGBA", (64, 64), (0, 0, 0, 0))
        
        # Resize source to fit
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
