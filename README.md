# MonsterChromatic

**A "Sarcastic Horror" roguelike survival game built with Godot 4.x**

> *"Prolonging the inevitable."*

## 🎮 About

MonsterChromatic is a top-down roguelike where you survive waves of enemies in a cynical graveyard while a sarcastic shopkeeper mocks your futile attempts at survival. Collect upgrades, stack weapons, and embrace the dark comedy of your inevitable demise.

### Core Features
- **Sarcastic Horror Aesthetic**: Hand-painted art with thick black outlines and cynical humor
- **Weapon Stacking System**: Collect and upgrade multiple weapons that attack simultaneously
- **Wave-Based Survival**: Face increasingly difficult enemy waves
- **Interactive Shop**: A sarcastic shopkeeper offers "helpful" upgrades with 16 unique cynical quotes
- **Mobile-First Design**: Optimized for portrait mobile screens with touch-friendly UI

## 📱 Platform

- **Primary Target**: Mobile (Android/iOS) - Portrait orientation
- **Development Platform**: Windows
- **Engine**: Godot 4.x

## 🎨 Visual Style

MonsterChromatic features a unique "Sarcastic Horror" aesthetic:
- Hand-painted characters with thick black contours
- Dead, earthy color palette (beige, brown, grey, muted greens)
- Wobble animations instead of traditional walk cycles
- Self-aware, cynical UI and dialogue
- Torn parchment and rusted metal UI elements

## 🛍️ Shop System (Recently Completed)

The shop screen transforms the typical roguelike upgrade menu into a character-driven experience:
- **Interactive Shopkeeper**: A hooded merchant with wobble animations and 3 reaction types
- **Sarcastic Dialogue**: 16 unique cynical quotes that change on click
- **Thematic Cards**: Upgrade cards with jagged edges and 8 texture variants
- **AI-Generated Icons**: Hand-drawn style icons for health, speed, and weapons
- **Mobile Layout**: 2x2 grid with large touch targets (280x380px cards)

## 🎯 Current State

**Version**: 0.3.0 (2026-01-08)

✅ **Completed**:
- Core movement and combat mechanics
- Enemy spawning and AI
- XP and leveling system
- Weapon stacking (Axe, Hammer)
- Procedural environment generation
- Complete shop UI with interactive shopkeeper
- Mobile optimization and testing tools

🚧 **In Progress**:
- Content expansion (new enemies, weapons, biomes)
- Sound effects and music
- Additional polish and balancing

## 📁 Project Structure

```
MonsterChromatic/
├── assets/           # Sprites, textures, sounds
├── scenes/           # Game scenes and scripts
│   ├── autoload/    # Global managers
│   ├── debug/       # Development tools
│   ├── ui/          # User interface
│   └── ...
├── Documents/        # Design docs and dev logs
│   ├── QUICK_REFERENCE.md
│   ├── ArtGuide.md
│   ├── GameDesign.md
│   ├── Roadmap.md
│   └── ShopScreenUI/
├── CHANGELOG.md     # Version history
└── README.md        # This file
```

## 🚀 Getting Started

### Prerequisites
- Godot 4.x (latest stable recommended)
- Git (optional, for version control)

### Running the Project
1. Clone/download the repository
2. Open the project in Godot
3. Press **F5** to run
4. Press **F1** in-game to access Resolution Tester (for mobile testing)

### Development Tools
- **Resolution Tester**: Press F1 to test different mobile aspect ratios
- **Development Logs**: See `Documents/` for detailed session notes
- **Quick Reference**: `Documents/QUICK_REFERENCE.md` for common tasks

## 📖 Documentation

- **[QUICK_REFERENCE.md](Documents/QUICK_REFERENCE.md)** - Quick start guide for development
- **[ArtGuide.md](Documents/ArtGuide.md)** - Visual style and aesthetic guidelines
- **[GameDesign.md](Documents/GameDesign.md)** - Core mechanics and design philosophy
- **[Roadmap.md](Documents/Roadmap.md)** - Feature roadmap and priorities
- **[CHANGELOG.md](CHANGELOG.md)** - Version history and changes
- **[Shop UI Implementation](Documents/ShopScreenUI/implementation_summary.md)** - Detailed shop system docs

## 🎮 Controls

### Desktop
- **WASD / Arrow Keys**: Move
- **Mouse**: Aim and shoot (automatic)
- **Click Shopkeeper**: Hear sarcastic comment
- **F1**: Toggle Resolution Tester

### Mobile (Planned)
- **Touch Drag**: Move
- **Auto-aim**: Automatic targeting
- **Tap Cards**: Select upgrades
- **Tap Shopkeeper**: Hear sarcastic comment

## 🐛 Known Issues

- **Dust Particles**: Particle emitters sometimes remain stuck at spawn points (cosmetic only)

See [CHANGELOG.md](CHANGELOG.md) for full issue tracking.

## 📝 Development Logs

Daily development logs are maintained in `Documents/`:
- **2026-01-08**: Complete shop UI implementation (8 phases)
- **2025-11-27**: Earlier session
- **2025-11-22**: Initial systems

## 🎯 Next Steps

See [Roadmap.md](Documents/Roadmap.md) for detailed priorities.

**High Priority**:
- New enemy types (Golem, Shield Skeleton, Archer, etc.)
- New weapons (Sword, Spear, Magic Wand, etc.)
- Boss encounters

**Medium Priority**:
- Sound effects and ambient music
- Settings menu
- Meta-progression system

## 🎨 Art Assets

All art assets follow the "Sarcastic Horror" aesthetic with:
- Hand-painted style with visible brush strokes
- Thick black outlines (2-4px)
- Dead, earthy color palette
- Minimalist "bean/blob" character designs

Icon generation prompts (Gemini/Nano Banana) available in development logs.

## 📄 License

[License information to be added]

## 🙏 Credits

- **Development**: [Your Name/Team]
- **Art Style**: "Sarcastic Horror" original concept
- **Icon Generation**: Gemini AI (Google)
- **Engine**: Godot Engine

---

**MonsterChromatic** - Where survival is futile and the shopkeeper knows it.

*"Pick your poison. It won't help anyway."*
