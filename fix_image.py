from PIL import Image
import os

path = "/home/mladen/Unreal/Godot/Projects/MonsterChromatic/assets/pickups/xp_gem.png"
try:
    img = Image.open(path)
    print(f"Format: {img.format}, Mode: {img.mode}")
    # Force convert to RGBA common for Godot PNGs
    img = img.convert("RGBA")
    
    # Save as proper PNG
    new_path = "/home/mladen/Unreal/Godot/Projects/MonsterChromatic/assets/pickups/xp_gem_fixed.png"
    img.save(new_path, "PNG")
    print(f"Saved to {new_path}")
    
except Exception as e:
    print(f"Error: {e}")
