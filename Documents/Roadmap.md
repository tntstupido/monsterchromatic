# Roadmap Projekta

Ovaj dokument služi za planiranje budućih funkcionalnosti i praćenje ideja.

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
- [ ] **Bug Fixes**
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

- [ ] **Nova Oružja & Sistem**:
    - [x] **Weapon Stacking**: Oružja su sada trajna i mogu se gomilati (simultani napadi).
    - [x] **Level-up Mehanika**: Nadogradnja postojećeg oružja povećava damage i brzinu.
    - [ ] **Sword** (Melee, Cone Area).
    - [ ] **Spear** (Melee, Thrust/Pierce).
    - [ ] **Magic Wand** (Projectile, Auto-target closest).
    - [ ] **Crossbow** (Projectile, High Damage, Linear Aim).
    - [ ] **Garlic Aura** (AOE, Krug oko igrača).
    - [ ] **Molotov** (AOE, Ostavlja vatru na podu).
- [ ] **Novi Biomi**:
    - [ ] Stage 2: Haunted Castle

### Faza 3: Polish & Meta
- [ ] **Main Menu Shop**: Kupovina trajnih statova (Meta-progression).
- [ ] **Sound & Music**:
    - [x] Implementiran globalni `AudioManager` sistem (sa pitch randomization).
    - [ ] Dodati "slapstick" zvučne efekte (squish, wobble, impact).
    - [ ] Dodati mračne ambijentalne tonove.
    - [ ] Integrisati komične krike neprijatelja pri smrti.
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
