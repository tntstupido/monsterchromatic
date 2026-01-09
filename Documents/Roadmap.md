# Roadmap Projekta

Ovaj dokument služi za planiranje budućih funkcionalnosti i praćenje ideja.

## Nedavno Završeno

### 2026-01-09: Cursed Skull Balance & Debug Console
- [x] **Cursed Skull Weapon Polish**:
    - [x] Buff base damage: 18 → 25 (+38%)
    - [x] Explosion damage scaling: Fixed 10 → 75% of main damage
    - [x] Explosion radius increase: 40px → 120-200px (scales with level)
    - [x] Visual explosion effect: Purple ring showing AOE radius
    - [x] Custom CursedSkullWeapon class for advanced scaling
- [x] **Debug Console Fixes**:
    - [x] F3 enemy spawning now works (added spawn_enemy methods)
    - [x] Removed debug print spam
- [x] **Documentation**:
    - [x] Created 2026-01-09_Log.md with detailed session notes
    - [x] Updated DebugConsole.md with new Cursed Skull stats
    - [x] Updated Roadmap.md progress tracking

## Prioritetno (Sledeće)
- [x] **Testiranje Čekića (Hammer)**:
    - Postaviti kao početno oružje.
    - Proveriti hitbox i animaciju (spin attack).
    - Podesiti parametre (damage, cooldown).
- [x] **Core Mechanics**
    - [x] Movement & shooting (Basic)
    - [x] Enemy spawning/AI (Basic)
    - [x] Progression System (XP, Level Up, Waves)
- [x] **Atmospheric & Narrative Identity**
    - [x] Define "Sarcastic Horror" core experience.
    - [x] Implement "Wobble" procedural animation for characters.
    - [x] Create the Art & Style Guide ([ArtGuide.md](file:///home/mladen/Unreal/Godot/Projects/MonsterChromatic/Documents/ArtGuide.md)).
    - [x] Implement Sarcastic Speech Bubble system.
    - [x] **Vizuelni Efekti (VFX)**: Dodata prašina (dust particles) pri kretanju.
- [x] **Shop UI Revamp ("The Crypt")** - ✅ COMPLETED 2026-01-08
    - [x] **Dedicated Shopkeeper Character**: Kreiran custom sprite (hooded merchant) sa continuous wobble animacijom.
    - [x] **Interactive Shopkeeper**: Clickable sa 3 random reakcije (wiggle, bounce, shrug) i cooldown sistemom (0.5s).
    - [x] **Sarcastic Speech Bubbles**: Integrisano 16 sarkastičnih komentara sa persistent bubble mode-om.
    - [x] **Upgrade Icons**: 4 AI-generisane ikonice (health, speed, axe, hammer) sa match-based loading sistemom.
    - [x] **Jagged Card Edges**: Implementirano sa 8 texture varijanti (6 paper + 2 metal) sa random selekcijom.
    - [x] **Mobile Layout Optimization**: 2x2 grid layout, card size 280x380, icon 120x120, optimizovano za portrait.
    - [x] **Resolution Testing Tool**: Debug tool (`ResolutionTester.gd`) za testiranje 6 mobilnih aspect ratio-a.
    - [x] **Code Quality**: Sva editor upozorenja ispravljenja (UID, shadowing, unused params).
- [x] **Sound System Implementation** - ✅ COMPLETED 2026-01-09
    - [x] **Enemy Sound Integration**: Dodati death_sound, hurt_sound, attack_sound, idle_sound sa intervalom u Enemy.gd.
    - [x] **Weapon Sound System**: Integrisani attack_sound, hit_sound, level_up_sound u Weapon.gd base class.
    - [x] **Player Sound Effects**: Implementirani hurt_sound, death_sound, heal_sound u Player.gd.
    - [x] **Experience Manager**: Dodat level_up_sound u ExperienceManager.gd.
    - [x] **Inheritance Fixes**: Promenjeno extends "path" u extends ClassName u MeleeWeapon.gd i RangedWeapon.gd.
- [x] **Weapon Polish & Graphics** - ✅ COMPLETED 2026-01-09
    - [x] **Hammer Animation Overhaul**: Kompletna rewrite HammerWeapon.gd sa anticipation animacijom, smooth easing krivama, motion trail efektom, i counterclockwise rotacijom.
    - [x] **Axe Graphics Update**: Zamenjeni placeholder sprites (icon.svg) sa proper axe.png grafikom u Axe.tscn i AxeProjectile.tscn.
    - [x] **Boomerang Projectile Rewrite**: Dodat motion trail effect, dinamička spin brzina (1.5x brže pri vraćanju), i code cleanup u BoomerangProjectile.gd.
- [x] **Bug Fixes**
    - [x] **UID Warnings**: Ispravljeni invalid UID-evi u wave_1.tres, wave_2.tres, wave_boss.tres (SlimeEnemy, BatEnemy, FastEnemy, BossEnemy).
    - [ ] **Dust Particles Cleanup**: DustParticles nodes ne brišu se pravilno i ostaju zaglavljeni na spawn tačkama.

## Planirane Funkcionalnosti (Backlog)

### Faza 2: Content Expansion (Sadržaj)
- [ ] **Novi Neprijatelji (Generisanje & Implementacija)**:
    - [ ] **Golem (Tank)**:
        - Asset: Kameni div, spor.
        - Logic: Veliki HP, otporan na knockback.
    - [ ] **Shield Skeleton**:
        - Asset: Kostur sa štitom.
        - Logic: Blokira projektile spreda.
    - [ ] **Spitter Plant (Ranged)**:
        - Asset: Biljka mesožderka.
        - Logic: Stoji i puca na igrača.
    - [ ] **Archer**:
        - Asset: Tamni strelac.
        - Logic: Beži od igrača (kiting) i puca.
    - [ ] **Exploder**:
        - Asset: Nestabilno čudovište.
        - Logic: Eksplodira pri kontaktu.
    - [ ] **Summoner**:
        - Asset: Čarobnjak.
        - Logic: Stvara nove slabe neprijatelje.

- [ ] **Novi Boss-ovi**:
    - [ ] **Chromatic Golem** (Menja boje/otpornosti).
    - [ ] **The Void Lord** (Finalni boss, Bullet Hell).

- [ ] **Nova Oružja & Sistem** - 🎯 EXPANDED PLAN 2026-01-09
    - [x] **Weapon Stacking**: Oružja su sada trajna i mogu se gomilati (simultani napadi).
    - [x] **Level-up Mehanika**: Nadogradnja postojećeg oružja povećava damage i brzinu.
    - [ ] **15 Thematic Weapons** (detaljno opisano u [WeaponDesignDoc.md](WeaponDesignDoc.md)):
        - **Tier 1 - Simple Extensions** (3 weapons):
            - [x] **Blessed Cross** (Ranged, 4-way pierce projectiles) - ✅ Implemented
            - [x] **Cursed Skull** (Ranged, homing explosive) - ✅ Implemented & Balanced 2026-01-09
            - [x] **Prayer Beads** (Melee, orbital chain) - ✅ Implemented
        - **Tier 2 - New Projectile Behaviors** (4 weapons):
            - [ ] **Dark Tome** (Ranged, homing page burst)
            - [ ] **Bone Shards** (Ranged, wide cone spread)
            - [ ] **Haunted Candle** (Ranged, sine wave wisps with DOT)
            - [ ] **Raven Familiar** (Pet, autonomous dive attacks)
        - **Tier 3 - Area-of-Effect & Ground** (4 weapons):
            - [ ] **Holy Water** (Ranged, ground puddles with persistent damage)
            - [ ] **Plague Cloud** (Aura, passive poison AOE around player)
            - [ ] **Necrotic Touch** (Melee, lifesteal beam)
            - [ ] **Blood Splatter** (Ranged, cone shotgun with knockback)
        - **Tier 4 - Unique & Complex** (4 weapons):
            - [ ] **Tombstone** (Summon, turret that spawns skeleton minions)
            - [ ] **Ghost Chain** (Melee, spectral whip with chain physics)
            - [ ] **Bone Scythe** (Melee, 180° devastating arc)
            - [ ] **Will-o'-Wisp** (Ranged, explosive orb with chain reactions)
- [ ] **Novi Biomi**:
    - [ ] Stage 2: Haunted Castle

### Faza 3: Polish & Meta
- [ ] **Main Menu Shop**: Kupovina trajnih statova (Meta-progression).
- [/] **Sound & Music**:
    - [x] Implementiran globalni `AudioManager` sistem (sa pitch randomization).
    - [x] Integrisani sound effects u Enemy.gd, Weapon.gd, Player.gd, ExperienceManager.gd.
    - [ ] Generisati i dodati "slapstick" zvučne efekte (squish, wobble, impact).
    - [ ] Generisati i dodati mračne ambijentalne tonove (background music).
    - [ ] Generisati komične krike neprijatelja pri smrti.
- [ ] **Settings Meni**: Zvuk, kontrole.

### Faza 2.5: Environment & Atmosphere (Groblje)
- [/] **Unapređenje Okruženja**:
    - [x] Implementiran sistem Y-sortiranih interaktivnih propova.
    - [x] **Vegetacija (Foliage)**: Implementiran novi `foliage_1.png` tileset sa randomizacijom kroz `Foliage.gd`.
    - [x] **Podloga (Floor)**: Implementirana proceduralna "beskonačna" podloga kroz `ProceduralFloor.gd`.
    - [x] **Propovi**: Implementirana proceduralna "beskonačna" generacija headstone-a i drveća (Refaktorisan `PropSpawner.gd`).

## Balansiranje i Poliranje
- [x] **Balansiranje Težine**:
    - [x] Podešen HP neprijatelja (30), damage oružja (10/15/40), i spawn rate (2.0→0.4).
    - [ ] Finalizacija krive težine kroz testiranje.
- [ ] **Proširenje Dijaloškog Sistema**:
    - [ ] Dodati još sarkastičnih komentara (različiti za različite tipove neprijatelja).
    - [ ] Revidirati trigere (vremenska ograničenja, specifične situacije poput Boss borbi).
- [x] **Poliranje Animacija Oružja**:
    - [x] Podešavanje Hammer impact animacije (shake i scale efekti).
- [ ] **Ekonomija Igre**:
    - Ako se uvede valuta/shop, balansirati cene i zaradu.

## Ideje (Backlog)
- Power-ups (štit, brzina, health potion).
- Shop sistem (kupovina oružja/upgrade-a).
- High Score tabela.
