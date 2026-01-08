# MonsterChromatic - Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

## [Unreleased]

### Todo
- Fix DustParticles cleanup bug (nodes remain stuck at spawn points)
- Add new enemy types (Golem, Shield Skeleton, Archer, Exploder, Summoner)
- Add new weapons (Sword, Spear, Magic Wand, Crossbow, Garlic Aura, Molotov)
- Add sound effects and music
- Add new biomes (Haunted Castle)

## [0.3.0] - 2026-01-08

### Added - Shop UI Revamp (Complete)
- **Dedicated Shopkeeper Character**: Custom hooded merchant sprite with continuous wobble animation
- **Interactive Shopkeeper System**:
  - Clickable with 3 random reaction animations (wiggle, bounce, shrug)
  - 0.5 second cooldown to prevent spam
  - 16 unique sarcastic quotes that rotate on click
- **Persistent Speech Bubbles**: Speech bubbles stay visible in shop until new quote is triggered
- **Upgrade Icons**: 4 AI-generated icons (health, speed, axe, hammer) with hand-drawn style
- **Jagged Card Edges**: 8 texture variants (6 paper + 2 metal) for "torn paper" aesthetic
- **Mobile-Optimized Layout**:
  - 2x2 grid layout instead of 1x3
  - Card size increased 40% (280x380px)
  - Icon size increased 50% (120x120px)
  - Font sizes increased for readability
  - Centered grid layout with proper spacing
- **Resolution Tester Tool**: Debug tool for testing 6 mobile aspect ratios (toggle with F1)

### Changed
- Shop screen layout from horizontal (1x3) to grid (2x2) for better mobile support
- Upgrade count from 3 to 4 for more variety
- Card background from ColorRect to TextureRect with random texture selection
- Card padding increased to 20px to accommodate jagged edges
- Shopkeeper size increased from 128x128 to 192x192 for better visibility
- Reduced vertical spacing: ShopkeeperArea (150→120px), Spacer (80→30px)

### Fixed
- Speech bubble destruction bug causing null instance crashes
- Invalid UID references in `Axe.tscn` and `AxeProjectile.tscn`
- Unused parameter warning in `Upgrade.gd`
- Shadowed global identifier in `UpgradeManager.gd`
- Shadowed variable names in `ResolutionTester.gd`
- Integer division warning in `HUD.gd`
- All Godot editor warnings resolved

### Technical Details
- Enhanced `SpeechBubble.gd` with persistent mode (`auto_hide` parameter)
- Implemented tween tracking to prevent memory leaks
- Added icon loading system with match statement for upgrade IDs
- Created comprehensive documentation in `Documents/ShopScreenUI/`

## [0.2.0] - 2025-11-27

### Added
- Basic shop screen with Ghost Shopkeeper (using enemy sprite)
- Speech bubble integration with sarcastic quotes (initial 6 quotes)
- Hover animations for upgrade cards (scale + wobble)
- Card text color adjusted to black for readability

### Changed
- Updated `Roadmap.md` and `ArtGuide.md` with Shop UI requirements

## [0.1.0] - 2025-11-22 and earlier

### Added - Core Systems
- **Player Movement & Combat**: Basic top-down movement with shooting mechanics
- **Enemy System**: Basic enemy spawning and AI behavior
- **Progression System**: XP, leveling, wave-based difficulty
- **Weapon System**:
  - Axe (boomerang projectile)
  - Hammer (spinning melee)
  - Weapon stacking (multiple weapons simultaneously)
  - Level-up mechanic for existing weapons
- **Environment System**:
  - Procedural infinite floor generation
  - Y-sorted interactive props
  - Foliage system with randomization
  - Procedural prop spawning (headstones, trees)
- **VFX System**: Dust particles on movement
- **Audio System**: Global AudioManager with pitch randomization
- **UI System**:
  - HUD with health, XP bar, timer, wave counter
  - Basic level-up screen
  - Sarcastic speech bubble system

### Design & Art
- Established "Sarcastic Horror" aesthetic
- Created Art & Style Guide
- Implemented wobble animations for characters
- Hand-painted art style with thick black outlines
- Dead, earthy color palette

### Balancing
- Enemy HP set to 30
- Weapon damage balanced (10/15/40)
- Spawn rate adjusted (2.0→0.4)

### Known Issues
- **DustParticles Cleanup**: Particle nodes remain stuck at spawn points (cosmetic only)

---

## Documentation

For detailed development logs, see:
- `Documents/2026-01-08_Log.md` - Shop UI implementation (8 phases)
- `Documents/2025-11-27_Log.md` - Earlier session
- `Documents/2025-11-22_Log.md` - Earlier session

For project overview:
- `Documents/QUICK_REFERENCE.md` - Quick start guide
- `Documents/Roadmap.md` - Feature roadmap
- `Documents/ArtGuide.md` - Visual style guide
- `Documents/GameDesign.md` - Core mechanics

For Shop UI details:
- `Documents/ShopScreenUI/implementation_summary.md` - Complete implementation guide
- `Documents/ShopScreenUI/shopscreen.md` - Original concept
