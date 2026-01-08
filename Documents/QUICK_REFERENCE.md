# MonsterChromatic - Quick Reference Guide

**Last Updated**: 2026-01-08
**Godot Version**: 4.x
**Platform**: Windows (primary), targeting Mobile

## 📁 Project Structure

```
MonsterChromatic/
├── assets/
│   ├── audio/                 # Sound effects & music
│   ├── enemies/               # Enemy sprites
│   ├── environment/           # Tileset, props, foliage
│   ├── player/                # Player sprite & animations
│   ├── ui/
│   │   ├── icons/            # Upgrade icons (health, speed, weapons)
│   │   └── shop/             # Shop screen assets
│   ├── vfx/                  # Visual effects (particles, etc.)
│   └── weapons/              # Weapon sprites
│
├── scenes/
│   ├── autoload/             # Global managers (singletons)
│   │   ├── AudioManager.gd
│   │   ├── ExperienceManager.gd
│   │   └── UpgradeManager.gd
│   ├── debug/                # Debug tools
│   │   └── ResolutionTester  # Mobile resolution testing (F1 to toggle)
│   ├── enemy/                # Enemy scenes & scripts
│   ├── player/               # Player scene & script
│   ├── projectile/           # Projectile scenes
│   ├── resources/            # Custom resource types (Upgrade, WeaponUpgrade)
│   ├── ui/                   # UI scenes
│   │   ├── HUD              # In-game HUD (health, XP, timer)
│   │   ├── LevelUpScreen    # Shop/Upgrade screen ✅ COMPLETED
│   │   ├── UpgradeCard      # Individual upgrade card
│   │   └── SpeechBubble/    # Sarcastic speech bubble system
│   ├── vfx/                 # VFX scenes (DustParticles, etc.)
│   ├── weapon/              # Weapon scenes (Axe, Hammer)
│   └── world/               # World, PropSpawner, ProceduralFloor
│
└── Documents/               # Project documentation
    ├── 2026-01-08_Log.md    # Today's detailed development log
    ├── ArtGuide.md          # Visual style & aesthetic guidelines
    ├── GameDesign.md        # Core mechanics & design philosophy
    ├── Roadmap.md           # Feature roadmap & task tracking
    ├── QUICK_REFERENCE.md   # This file
    └── ShopScreenUI/        # Shop UI specific docs
        ├── shopscreen.md               # Original concept
        └── implementation_summary.md   # Full implementation details
```

## 🎮 Core Systems

### Game Loop
1. Player spawns in procedural graveyard
2. Enemies spawn in waves (increasing difficulty)
3. Player gains XP from kills
4. Level up → Shop Screen opens (game paused)
5. Player selects upgrade → Game continues
6. Repeat until death

### Autoloads (Global Singletons)
- **AudioManager**: Sound effect management with pitch randomization
- **ExperienceManager**: XP tracking, level progression
- **UpgradeManager**: Upgrade pool management, application logic

## 🛍️ Shop UI System (COMPLETED)

### Key Files
- `scenes/ui/LevelUpScreen.tscn` - Main layout (2x2 grid)
- `scenes/ui/LevelUpScreen.gd` - Shopkeeper logic
- `scenes/ui/UpgradeCard.tscn` - Card layout (280x380px)
- `scenes/ui/UpgradeCard.gd` - Icon loading, texture randomization

### Shopkeeper Interactions
- **Click**: Random sarcastic quote (16 variations)
- **Animations**: Wiggle, Bounce, or Shrug (random)
- **Cooldown**: 0.5 seconds between clicks
- **Speech Bubble**: Persistent (doesn't auto-hide)

### Card System
- **Textures**: 8 variants (6 paper + 2 metal), randomly assigned
- **Icons**: 4 AI-generated icons (health, speed, axe, hammer)
- **Layout**: 2x2 grid, centered, mobile-optimized
- **Size**: 280x380px cards, 120x120px icons

### Upgrade IDs
```gdscript
"heal"          → health_icon.png
"speed"         → speed_icon.png
"weapon_axe"    → axe_icon.png
"weapon_hammer" → hammer_icon.png
```

## 🎨 Art & Style Guide

### Core Aesthetic: "Sarcastic Horror"
- Hand-painted look with thick black outlines
- Dead, earthy colors (beige, brown, grey, muted green)
- Wobble animations for characters and props
- Cynical humor and dark comedy

### UI Design Principles
- No clean rectangles - everything looks torn, cracked, or rusted
- Heavy black outlines on all UI elements
- Text is sarcastic and self-aware
- Interactive elements wobble or shake on hover/click

### Color Palette
- Background: Dark greys, blacks
- UI Elements: Beige, brown, dirty off-white
- Accents: Muted greens, rust orange
- Text: Black or near-black for readability

## 🔧 Common Tasks

### Adding New Upgrade
1. Open `UpgradeManager.gd`
2. Add new upgrade to `_init_pool()`:
   ```gdscript
   var new_upgrade = Upgrade.new()
   new_upgrade.id = "unique_id"
   new_upgrade.title = "Display Title"
   new_upgrade.description = "Description (Sarcastic subtext)"
   _upgrade_pool.append(new_upgrade)
   ```
3. Add icon match case in `UpgradeCard.gd`:
   ```gdscript
   "unique_id":
       icon_path = "res://assets/ui/icons/new_icon.png"
   ```
4. Implement effect in `UpgradeManager.apply_upgrade()`

### Testing Different Mobile Resolutions
1. Run game
2. Press **F1** to open ResolutionTester
3. Click preset buttons to test different aspect ratios
4. Press **F1** again to hide tester

### Adding Sarcastic Shopkeeper Quote
1. Open `scenes/ui/LevelUpScreen.gd`
2. Add to `sarcastic_quotes` array (line 14-31)
3. Quote auto-rotates randomly on shopkeeper clicks

## 🐛 Known Issues

### Dust Particles Cleanup Bug
- **Status**: ❌ Unresolved
- **Symptom**: DustParticles nodes remain stuck at enemy spawn points
- **Added to Roadmap**: Yes
- **Priority**: Low (cosmetic issue)

## 📱 Mobile Optimization

### Target Resolutions
- iPhone SE (9:16) - 375x667
- iPhone 14 (9:19.5) - 390x844
- Pixel 7 (9:20) - 412x915
- Galaxy S23 (9:19.5) - 360x780
- iPad (3:4) - 810x1080

### Design Guidelines
- **Minimum Touch Target**: 44x44px (Apple HIG standard)
- **Font Sizes**: 18px minimum for body text
- **Layout**: Portrait-first, 2-column grid for cards
- **Spacing**: 40px gaps for comfortable touch
- **UI Scale**: 40% larger than desktop equivalents

## 🎯 Current Priorities (from Roadmap)

### High Priority
1. Content Expansion:
   - [ ] New enemy types (Golem, Shield Skeleton, Archer, etc.)
   - [ ] New weapons (Sword, Spear, Magic Wand, etc.)
   - [ ] Boss enemies

### Medium Priority
1. Sound & Music:
   - [ ] Slapstick sound effects
   - [ ] Dark ambient music
   - [ ] Enemy death sounds

### Low Priority
1. Bug Fixes:
   - [ ] Dust Particles cleanup
2. Polish:
   - [ ] More sarcastic dialogue
   - [ ] Advanced animations

## 🚀 Quick Commands

### Godot Editor
- **F5**: Run project
- **F6**: Run current scene
- **Ctrl+Shift+F**: Search in files
- **Ctrl+Alt+F**: Replace in files

### Git (if initialized)
```bash
git add .
git commit -m "Description"
git push
```

## 📝 Development Log Files

All daily logs are in `Documents/` with format `YYYY-MM-DD_Log.md`:
- **2026-01-08_Log.md**: Shop UI complete implementation (8 phases)
- **2025-11-27_Log.md**: Earlier session
- **2025-11-22_Log.md**: Earlier session

## 🔗 Important References

- **Art Guide**: `Documents/ArtGuide.md`
- **Game Design**: `Documents/GameDesign.md`
- **Roadmap**: `Documents/Roadmap.md`
- **Shop UI Concept**: `Documents/ShopScreenUI/shopscreen.md`
- **Shop UI Implementation**: `Documents/ShopScreenUI/implementation_summary.md`

## 💡 Design Philosophy

### Core Pillars
1. **Sarcastic Horror**: Dark humor + horror aesthetic
2. **Accessible Roguelike**: Easy to learn, hard to master
3. **Mobile-First**: Designed for portrait phone screens
4. **Visual Identity**: Hand-painted, thick outlines, wobble animations

### Player Experience Goals
- Feel cynically amused by the game's self-aware humor
- Experience satisfying combat with stackable weapons
- Enjoy quick 5-10 minute runs perfect for mobile
- Discover personality in every UI interaction

## 🎬 Next Session Quick Start

1. Read `Documents/2026-01-08_Log.md` for latest changes
2. Check `Documents/Roadmap.md` for current priorities
3. Review any new **Known Issues** section above
4. Continue with content expansion (new enemies/weapons)

---

**Need Help?**
- All detailed implementation notes are in daily log files
- Shop UI has dedicated `implementation_summary.md`
- Use ResolutionTester (F1) for mobile testing
- Check ArtGuide.md for visual style questions
