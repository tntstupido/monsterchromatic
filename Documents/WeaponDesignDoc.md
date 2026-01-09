# Weapon Design Document - Sarcastic Horror Arsenal

**Version**: 1.0
**Date**: 2026-01-09
**Project**: MonsterChromatic

---

## Overview

This document outlines 15 new thematic weapons for MonsterChromatic, expanding beyond conventional medieval weapons to embrace the game's "Sarcastic Horror" aesthetic. Each weapon is designed to blend dark humor with horror visuals while maintaining diverse and engaging gameplay mechanics.

---

## Design Philosophy

**Core Principles:**
1. **Thematic Consistency**: All weapons fit the "Sarcastic Horror" theme (dark humor + horror visuals)
2. **Mechanical Diversity**: Each weapon offers unique gameplay patterns
3. **Visual Identity**: Distinctive sprites that telegraph their purpose
4. **Mobile-Friendly**: Clear visuals and satisfying feedback on small screens
5. **Scalable Complexity**: Organized in tiers from simple to complex implementation

---

## Weapon Roster

### Tier 1: Simple Extensions (Modify Existing Systems)

These weapons extend existing weapon classes with minimal new mechanics.

#### 1. **Blessed Cross**
- **Type**: Ranged (Projectile)
- **Base**: Extends `RangedWeapon.gd`
- **Mechanics**:
  - Fires blessed crosses in cardinal directions (4-way spread)
  - Projectiles deal holy damage and pierce through 2 enemies
  - Golden glow trail effect
- **Visual**: Glowing silver cross with divine aura
- **Flavor**: "The power of Christ compels you... to die faster."
- **Stats** (Level 1):
  - Damage: 12
  - Cooldown: 1.0s
  - Speed: 450
  - Pierce: 2
- **Implementation Notes**:
  - Reuse projectile pooling system
  - Add `pierce_count` property to Projectile.gd
  - Simple 4-direction spread pattern (0°, 90°, 180°, 270°)

#### 2. **Cursed Skull**
- **Type**: Ranged (Homing Projectile)
- **Base**: Extends `RangedWeapon.gd` with homing behavior
- **Mechanics**:
  - Spawns floating skull that slowly homes toward nearest enemy
  - Explodes on impact with small AOE (radius: 40px)
  - Purple smoke trail
- **Visual**: Grinning skull with dark purple aura and glowing eye sockets
- **Flavor**: "Alas, poor Yorick... now he's YOUR problem."
- **Stats** (Level 1):
  - Damage: 18 (direct), 10 (AOE)
  - Cooldown: 1.5s
  - Speed: 300 (slower but homes)
  - AOE Radius: 40px
- **Implementation Notes**:
  - Add homing behavior to projectile (similar to boomerang return logic)
  - Small explosion sprite on impact
  - Use Area2D overlap for AOE damage

#### 3. **Prayer Beads**
- **Type**: Melee (Orbital)
- **Base**: Extends `MeleeWeapon.gd`
- **Mechanics**:
  - Chain of beads orbits player at fixed radius (90px)
  - Continuous damage on contact (no swing cooldown)
  - Rotates slowly (3 RPM)
  - Multiple beads spaced evenly around orbit
- **Visual**: String of wooden prayer beads with subtle glow
- **Flavor**: "Pray they don't get close. Spoiler: They will."
- **Stats** (Level 1):
  - Damage: 8 per hit
  - Hit Rate: 0.2s (per bead)
  - Orbit Radius: 90px
  - Rotation Speed: 3 RPM
  - Bead Count: 6
- **Implementation Notes**:
  - Similar to Hammer but continuous rotation
  - Multiple hitbox nodes spaced around orbit
  - No swing animation, just constant rotation

---

### Tier 2: New Projectile Behaviors

These weapons require new projectile types with unique movement patterns.

#### 4. **Dark Tome**
- **Type**: Ranged (Homing Projectile)
- **Base**: New projectile type `HomingProjectile.gd`
- **Mechanics**:
  - Summons floating pages that aggressively home toward enemies
  - Multiple pages fire in sequence (burst of 3)
  - Pages phase through enemies (pierce all)
- **Visual**: Torn parchment pages with dark glyphs, swirling motion
- **Flavor**: "The pen is mightier than the sword. These pages prove it."
- **Stats** (Level 1):
  - Damage: 10 per page
  - Cooldown: 2.0s
  - Pages per Burst: 3
  - Speed: 400
  - Homing Strength: High
- **Implementation Notes**:
  - Create `HomingProjectile.gd` extending Projectile
  - Strong homing with smooth steering
  - Burst fire with 0.1s delay between pages

#### 5. **Bone Shards**
- **Type**: Ranged (Spread Projectile)
- **Base**: Extends `RangedWeapon.gd`
- **Mechanics**:
  - Fires cone of bone fragments (7 projectiles)
  - Wide spread angle (60° total)
  - Short range but high damage
  - Fragments tumble/rotate as they fly
- **Visual**: Jagged bone fragments, pale white with dark stains
- **Flavor**: "Spare ribs, anyone? No? More for the monsters."
- **Stats** (Level 1):
  - Damage: 8 per shard
  - Cooldown: 0.8s
  - Shards: 7
  - Speed: 600
  - Spread: 60°
  - Max Distance: 200px
- **Implementation Notes**:
  - Reuse projectile system with spread pattern
  - Add rotation to projectile sprite
  - Short lifetime for limited range

#### 6. **Haunted Candle**
- **Type**: Ranged (Wisp Projectile)
- **Base**: New projectile type `WispProjectile.gd`
- **Mechanics**:
  - Spawns flame wisps that float in sinusoidal pattern
  - Wisps move slowly but persist for long duration
  - Creates zone control effect
  - Burns enemies on contact (damage over time tick)
- **Visual**: Flickering ghostly flame (blue-green) with wax drips
- **Flavor**: "Light a candle, curse the darkness. Literally."
- **Stats** (Level 1):
  - Damage: 6 per tick (0.3s interval)
  - Cooldown: 1.5s
  - Speed: 250
  - Duration: 4.0s
  - Sine Wave Amplitude: 30px
- **Implementation Notes**:
  - Create `WispProjectile.gd` with sine wave motion
  - Add DOT (damage over time) tick system
  - Long lifetime for zone control

#### 7. **Raven Familiar**
- **Type**: Ranged (Pet/Orbital)
- **Base**: New weapon type `PetWeapon.gd`
- **Mechanics**:
  - Summons raven that orbits player
  - Raven periodically dives at nearest enemy
  - Returns to orbit after attack
  - Autonomous targeting
- **Visual**: Black raven with red eyes, wing flap animation
- **Flavor**: "Nevermore? More like 'Die some more.'"
- **Stats** (Level 1):
  - Damage: 15 per dive
  - Dive Cooldown: 2.5s
  - Orbit Radius: 120px
  - Dive Speed: 800
  - Detection Range: 300px
- **Implementation Notes**:
  - Create `PetWeapon.gd` base class
  - State machine: ORBIT → DIVE → RETURN
  - Autonomous enemy detection
  - Smooth animation between states

---

### Tier 3: Area-of-Effect & Ground Effects

These weapons require new damage zones and environmental interactions.

#### 8. **Holy Water**
- **Type**: Ranged (Ground AOE)
- **Base**: New system with ground puddles
- **Mechanics**:
  - Throws vial that shatters on ground
  - Creates holy water puddle (radius: 80px)
  - Puddle persists for 5s, damages enemies inside
  - Multiple puddles can overlap
- **Visual**: Glass vial (projectile), glowing blue puddle (ground effect)
- **Flavor**: "Splash some faith on them. It's super effective."
- **Stats** (Level 1):
  - Damage: 12 per tick (0.5s interval)
  - Cooldown: 2.0s
  - Puddle Radius: 80px
  - Puddle Duration: 5.0s
  - Throw Distance: 250px
- **Implementation Notes**:
  - Create `GroundEffect.gd` base class (Area2D with timer)
  - Projectile spawns ground effect on collision/timeout
  - Animated sprite with glow shader for puddle

#### 9. **Plague Cloud**
- **Type**: Melee (Aura AOE)
- **Base**: New weapon type `AuraWeapon.gd`
- **Mechanics**:
  - Passive poisonous cloud around player
  - Constantly damages nearby enemies
  - Enemies take DOT effect that persists briefly after leaving cloud
  - Cloud pulses/breathes visually
- **Visual**: Sickly green miasma with swirling particles
- **Flavor**: "Social distancing, medieval style."
- **Stats** (Level 1):
  - Damage: 5 per tick (0.4s interval)
  - Aura Radius: 100px
  - Poison DOT: 3 damage per second for 2s
- **Implementation Notes**:
  - Create `AuraWeapon.gd` extending Weapon
  - Permanent Area2D that follows player
  - Apply poison status effect to enemies
  - Particle system for cloud visual

#### 10. **Necrotic Touch**
- **Type**: Melee (Drain)
- **Base**: Extends `MeleeWeapon.gd`
- **Mechanics**:
  - Dark energy beam extends from player toward mouse
  - Continuous beam (laser-like)
  - Drains enemy health and heals player (lifesteal)
  - Beam length limited by range
- **Visual**: Dark purple/black energy tendril with skulls
- **Flavor**: "Take their life force. Sharing is caring... for yourself."
- **Stats** (Level 1):
  - Damage: 10 per tick (0.2s interval)
  - Lifesteal: 30% of damage dealt
  - Max Range: 150px
  - Beam Width: 20px
- **Implementation Notes**:
  - Raycast or Area2D shaped as rectangle
  - Continuous damage while holding
  - Heal player on damage dealt
  - Line2D for beam visual with particle trail

#### 11. **Blood Splatter**
- **Type**: Ranged (Cone AOE)
- **Base**: New weapon type `ConeWeapon.gd`
- **Mechanics**:
  - Sprays blood in wide cone
  - Instant hit (no projectile)
  - Short range (shotgun-like)
  - Knockback effect
- **Visual**: Crimson blood spray with droplet particles
- **Flavor**: "Warning: May contain graphic violins. And violence."
- **Stats** (Level 1):
  - Damage: 20 (close), 10 (far)
  - Cooldown: 1.2s
  - Cone Angle: 90°
  - Max Range: 180px
  - Knockback: 200
- **Implementation Notes**:
  - Area2D in cone shape (multiple segments)
  - Damage falloff with distance
  - CPUParticles2D for blood spray effect
  - Apply knockback force to enemies

---

### Tier 4: Unique & Complex Systems

These weapons require entirely new systems and significant implementation work.

#### 12. **Tombstone**
- **Type**: Summon (Static Turret)
- **Base**: New weapon type `SummonWeapon.gd`
- **Mechanics**:
  - Places tombstone turret at location
  - Tombstone spawns skeleton minions periodically
  - Skeletons attack nearby enemies
  - Max 3 tombstones active
  - Tombstones can be destroyed by enemies
- **Visual**: Cracked gravestone with glowing runes, skeleton sprite
- **Flavor**: "Make new friends. Dead friends. Friendly dead friends?"
- **Stats** (Level 1):
  - Cooldown: 5.0s
  - Max Tombstones: 3
  - Tombstone HP: 50
  - Skeleton Spawn Rate: 3.0s
  - Skeleton Damage: 8
  - Skeleton HP: 20
- **Implementation Notes**:
  - Create `SummonWeapon.gd` and `Summon.gd` classes
  - Minion AI (simple enemy-seeking behavior)
  - Track active summons (max count)
  - Summons need health and can be destroyed

#### 13. **Ghost Chain**
- **Type**: Melee (Whip/Flail)
- **Base**: New weapon type `WhipWeapon.gd`
- **Mechanics**:
  - Spectral chain extends and retracts
  - Swings in arc toward mouse direction
  - Hits multiple enemies along path
  - Chain segments visible (like rope physics)
- **Visual**: Ethereal blue-white chain with shackle at end
- **Flavor**: "Chains? Really? What is this, a ghost BDSM dungeon?"
- **Stats** (Level 1):
  - Damage: 25
  - Cooldown: 1.0s
  - Max Length: 200px
  - Swing Arc: 120°
  - Chain Segments: 10
- **Implementation Notes**:
  - Complex: requires chain segment simulation
  - Multiple hitboxes along chain path
  - Smooth extension/retraction animation
  - Consider using Line2D with multiple points

#### 14. **Bone Scythe**
- **Type**: Melee (Wide Arc)
- **Base**: Extends `MeleeWeapon.gd`
- **Mechanics**:
  - Massive sweeping arc attack (180°)
  - Longer range than hammer
  - Slow but devastating
  - Reaper aesthetic with trail effect
- **Visual**: Large curved bone scythe with dark energy trail
- **Flavor**: "Death's intern. Still learning, still deadly."
- **Stats** (Level 1):
  - Damage: 45
  - Cooldown: 2.0s
  - Swing Arc: 180°
  - Range: 140px
  - Swing Duration: 0.6s
- **Implementation Notes**:
  - Similar to Hammer but 180° arc instead of 360°
  - Larger hitbox arc
  - Anticipation animation (pull back)
  - Wide trail effect

#### 15. **Will-o'-Wisp**
- **Type**: Ranged (Explosive)
- **Base**: New projectile type `ExplosiveProjectile.gd`
- **Mechanics**:
  - Launches floating orb that homes slowly
  - Detonates on contact or after duration
  - Large explosion radius
  - Chains to nearby explosives (if multiple active)
- **Visual**: Floating blue flame orb, explosion with ghostly faces
- **Flavor**: "Follow the lights, they said. You'll be fine, they said."
- **Stats** (Level 1):
  - Damage: 15 (direct), 25 (explosion)
  - Cooldown: 2.5s
  - Explosion Radius: 120px
  - Speed: 350 (homing)
  - Fuse Time: 3.0s
  - Chain Radius: 150px
- **Implementation Notes**:
  - Create `ExplosiveProjectile.gd` with timer
  - Large AOE damage on detonation
  - Check for other explosives in range for chain reaction
  - Dramatic explosion animation

---

## Implementation Roadmap

### Phase 1: Foundation (Tier 1 - 3 weapons)
**Effort**: ~4-6 hours
**Weapons**: Blessed Cross, Cursed Skull, Prayer Beads
- Extend existing systems
- Minimal new mechanics
- Focus on visual polish and balance

### Phase 2: Projectile Variety (Tier 2 - 4 weapons)
**Effort**: ~8-12 hours
**Weapons**: Dark Tome, Bone Shards, Haunted Candle, Raven Familiar
- Create new projectile behaviors (homing, sine wave, pet AI)
- Establish patterns for future projectile types
- Add projectile pooling for performance

### Phase 3: Area Control (Tier 3 - 4 weapons)
**Effort**: ~10-14 hours
**Weapons**: Holy Water, Plague Cloud, Necrotic Touch, Blood Splatter
- Develop ground effect system
- Create aura/persistent damage zones
- Implement status effects (poison, lifesteal)

### Phase 4: Advanced Systems (Tier 4 - 4 weapons)
**Effort**: ~16-24 hours
**Weapons**: Tombstone, Ghost Chain, Bone Scythe, Will-o'-Wisp
- Build summon/minion system
- Complex animation systems (chain physics)
- Explosive chain reactions

**Total Estimated Effort**: ~38-56 hours for all 15 weapons

---

## Asset Requirements

### Sprites Needed
For each weapon, generate sprites using the established "Sarcastic Horror" aesthetic (refer to [ArtGuide.md](ArtGuide.md)):

**Style Guidelines:**
- 128x128px base resolution (scale down 50% in-engine)
- Limited color palette (black, grays, accent colors)
- Jagged/rough edges (hand-drawn feel)
- Subtle gradients for depth
- Optional wobble animation (3-5 frames)

**Sprite List:**
1. Blessed Cross: Silver cross with golden glow
2. Cursed Skull: Grinning skull with purple aura
3. Prayer Beads: Wooden bead chain
4. Dark Tome (Pages): Torn parchment with dark glyphs
5. Bone Shards: Jagged bone fragments
6. Haunted Candle: Blue-green flame with wax
7. Raven Familiar: Black raven (3 frames: idle, flap, dive)
8. Holy Water: Glass vial + blue puddle effect
9. Plague Cloud: Green particle texture
10. Necrotic Touch: Dark energy beam segments
11. Blood Splatter: Blood spray particles
12. Tombstone: Cracked gravestone + skeleton minion
13. Ghost Chain: Ethereal chain segments + shackle
14. Bone Scythe: Large curved bone scythe
15. Will-o'-Wisp: Blue flame orb + explosion effect

### Sound Effects Needed
Follow established AudioManager system:
- Attack sounds (weapon activation)
- Hit sounds (impact feedback)
- Special sounds (explosions, summons, etc.)
- Refer to "Slapstick + Dark Ambient" style guide

---

## Balance Considerations

### Damage Scaling (per level)
- **Low DPS weapons** (continuous): +20% damage per level
- **Medium DPS weapons** (standard): +25% damage per level
- **High DPS weapons** (slow): +30% damage per level

### Cooldown Reduction
- -10% cooldown per level (minimum 0.3s)

### Range/AOE Scaling
- +15% range/radius per level

### Special Properties
- Some weapons gain additional projectiles/summons at levels 3, 5, 7

---

## Sarcastic Flavor Text Ideas

When player picks up weapon for first time (speech bubble):
- **Blessed Cross**: "Holy hardware! Now we're crusading!"
- **Cursed Skull**: "Finally, a head on your shoulders. Wait, that's not right..."
- **Prayer Beads**: "Time to rosary the competition."
- **Dark Tome**: "Books CAN kill. Checkmate, librarians!"
- **Bone Shards**: "Ribcage special! Warning: Contains calcium."
- **Haunted Candle**: "Mood lighting, but make it murderous."
- **Raven Familiar**: "Edgar Allan BORE no more!"
- **Holy Water**: "Baptism by fire. And water. Mostly pain."
- **Plague Cloud**: "Eau de Corpse. New fragrance."
- **Necrotic Touch**: "Life-stealing. Like taxes, but faster."
- **Blood Splatter**: "Clean-up on aisle EVERYWHERE."
- **Tombstone**: "Making friends. Dead friends."
- **Ghost Chain**: "Shackled to your fate. Literally."
- **Bone Scythe**: "Reaper cosplay intensifies."
- **Will-o'-Wisp**: "Follow the pretty lights to oblivion!"

---

## Technical Notes

### Performance Considerations
- Use object pooling for all projectiles
- Limit max simultaneous effects (pooled instances)
- Ground effects should have max count (8-10)
- Particle systems: use GPU particles where possible
- Minions: max 10 active simultaneously across all summons

### Mobile Optimization
- Ensure all weapons have clear visual feedback (hits feel good)
- Large enough hitboxes for precision on small screens
- Avoid weapons requiring precise mouse aim (prefer auto-aim/closest enemy)
- Test on target resolution (1080x2400)

### Code Architecture
Extend existing class hierarchy:
```
Weapon.gd (base)
├── MeleeWeapon.gd
│   ├── HammerWeapon.gd ✓
│   ├── PrayerBeads.gd (orbital)
│   ├── BoneScythe.gd (arc)
│   └── NecroticTouch.gd (beam)
├── RangedWeapon.gd
│   ├── BlessedCross.gd (piercing)
│   ├── CursedSkull.gd (homing)
│   ├── DarkTome.gd (burst)
│   ├── BoneShards.gd (spread)
│   ├── HauntedCandle.gd (wisp)
│   ├── HolyWater.gd (ground)
│   └── WilloWisp.gd (explosive)
├── AuraWeapon.gd (NEW)
│   └── PlagueCloud.gd
├── SummonWeapon.gd (NEW)
│   └── Tombstone.gd
├── PetWeapon.gd (NEW)
│   └── RavenFamiliar.gd
├── ConeWeapon.gd (NEW)
│   └── BloodSplatter.gd
└── WhipWeapon.gd (NEW)
    └── GhostChain.gd
```

---

## Next Steps

1. **Get user approval** for weapon designs and priorities
2. **Generate sprites** for Phase 1 weapons (Blessed Cross, Cursed Skull, Prayer Beads)
3. **Implement foundation** (Tier 1 weapons)
4. **Playtest and balance** before proceeding to next tier
5. **Iterate** based on gameplay feel and mobile testing

---

**Document Status**: Draft v1.0
**Ready for Review**: Yes
**Next Update**: After Phase 1 implementation
