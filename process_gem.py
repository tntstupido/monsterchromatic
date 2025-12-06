from PIL import Image

def process_gem():
    src_path = "/home/mladen/.gemini/antigravity/brain/9daf3b84-9fda-4d15-85bc-f6e8ee97074d/chromatic_horror_gem_1765050338224.png"
    dst_path = "/home/mladen/Unreal/Godot/Projects/MonsterChromatic/assets/pickups/blue_gem.png"
    
    try:
        img = Image.open(src_path).convert("RGBA")
        datas = img.getdata()
        
        new_data = []
        for item in datas:
            # Change all white (also shades of whites) to transparent
            if item[0] > 240 and item[1] > 240 and item[2] > 240:
                new_data.append((255, 255, 255, 0))
            else:
                new_data.append(item)
                
        img.putdata(new_data)
        
        # Crop tight bounding box
        bbox = img.getbbox()
        if bbox:
            img = img.crop(bbox)
            
        # Resize to 64x64
        img = img.resize((64, 64), Image.Resampling.LANCZOS)
        
        img.save(dst_path, "PNG")
        print(f"Processed and saved to {dst_path}")
        
    except Exception as e:
        print(f"Error: {e}")

if __name__ == "__main__":
    process_gem()
