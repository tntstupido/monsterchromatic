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

- [ ] **Nova Oružja**:
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
    - [x] Dodata Scary Tree varijanta (Smanjen broj na sceni radi preglednosti).
    - [ ] **Podloga (Floor)**: Kreirati "shaky" hand-painted tileset za zemlju (Veličina tile-ova: 256x256).
    - [ ] **Propovi**: Dodati Headstones i ostale grobljanske detalje koristeći postojeće/nove asete.

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
