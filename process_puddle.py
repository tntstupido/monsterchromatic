from PIL import Image

def process_puddle():
    src_path = "/home/mladen/.gemini/antigravity/brain/9daf3b84-9fda-4d15-85bc-f6e8ee97074d/green_slime_puddle_1765052900331.png"
    dst_path = "/home/mladen/Unreal/Godot/Projects/MonsterChromatic/assets/enemies/Sprites/slime_puddle.png"
    
    try:
        img = Image.open(src_path).convert("RGBA")
        datas = img.getdata()
        
        new_data = []
        for item in datas:
            # Distance from white logic
            dist = (255 - item[0]) + (255 - item[1]) + (255 - item[2])
            if dist < 60: # Threshold
                 new_data.append((255, 255, 255, 0))
            else:
                 new_data.append(item)
                 
        img.putdata(new_data)
        
        # Crop tight
        bbox = img.getbbox()
        if bbox:
            img = img.crop(bbox)
            
        # Resize to fit 64x64
        final_img = Image.new("RGBA", (64, 64), (0, 0, 0, 0))
        img.thumbnail((64, 64), Image.Resampling.LANCZOS)
        
        # Center
        x = (64 - img.width) // 2
        y = (64 - img.height) // 2
        
        final_img.paste(img, (x, y))
        
        final_img.save(dst_path, "PNG")
        print(f"Processed and saved to {dst_path}")
        
    except Exception as e:
        print(f"Error: {e}")

if __name__ == "__main__":
    process_puddle()
