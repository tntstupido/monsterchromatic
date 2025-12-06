# Dokument Dizajna Igre (Game Design Document) - MonsterChromatic

Ovaj dokument služi za definisanje mehanika progresije, sistema neprijatelja i sposobnosti.

## 1. Struktura Igranja (Game Loop)
Predlog je **"Roguelite Survival"** model (sličan Vampire Survivors / Brotato), gde igrač preživljava talase neprijatelja, sakuplja XP, jača tokom partije (Run), i na kraju gine/pobeđuje zadržavajući valutu za trajna pojačanja.

## 2. Sistem Neprijatelja i Talasa (Waves)
Umesto klasičnih nivoa, igra koristi **vremenski sistem**:
*   **Talasi (Waves)**:
    *   Spawn rate i težina neprijatelja rastu kako vreme prolazi.
    *   Svaki minut uvodi novi tip neprijatelja ili povećava njihov broj ("Horde" momenat).
*   **Boss Borbe**:
    *   Pojavljuju se na fiksnim vremenskim intervalima (npr. na 5:00, 10:00, 15:00).
    *   Boss "čisti" ekran od malih neprijatelja ili ih spawn-uje kao podšku.
    *   Ubistvo Bossa daje poseban kovčeg (Treasure Chest) sa velikim nagradama (npr. evolucija oružja).

## 3. Sistem Progresije (Abilities & Collectibles)

### A. Collectibles (Šta pada od neprijatelja?)
1.  **XP Gems (Iskustvo)**:
    *   Najčešći drop. Sakupljanjem se puni XP bar.
    *   Kada se napuni -> **Level Up**.
2.  **Gold / Chromatic Essence (Valuta)**:
    *   Ređi drop ili nagrada za ubijanje Boss-ova/Elite neprijatelja.
    *   Koristi se van partije (Global Progression).
3.  **Health Pickups (Hrana)**:
    *   Retko pada (npr. iz uništenih objekata ili srećom od neprijatelja) za lečenje.
4.  **Magnet / Bomb**:
    *   Privremeni power-ups (privlače sav XP ili unište sve na ekranu).

### B. Privremene Sposobnosti (In-Run Progression)
Kada igrač dobije Level Up, bira jednu od 3 nasumične opcije:
*   **Nova Oružja**: Dodavanje novog napada (npr. Axe, Magic Bolt) uz postojeći Hammer.
*   **Upgrade Oružja**: Povećanje Damage, Area, Speed, Cooldown postojećeg oružja.
*   **Passive Stats**: Armor, Move Speed, Regen, Pickup Range.
*   *Cilj*: Napraviti "build" koji može da preživi do kraja tajmera (npr. 20 minuta).

### C. Globalne Sposobnosti (Meta-Progression)
U glavnom meniju ("The Lair"), igrač troši sakupljeno zlato na trajna pojačanja:
*   **Base Stats**: Trajno povećanje Health-a, Damage-a, Brzine.
*   **Unlocks**: Otključavanje novih karaktera ili oružja da se pojave u budućim partijama.
*   **Reroll**: Mogućnost promene ponuđenih upgrade-ova tokom Level Up-a.

## 4. Specifikacije za Mobilnu Platformu (Android/iOS)
S obzirom da je platforma mobilna, sesije treba da budu kraće i intenzivnije ("Pick-up-and-play").

*   **Trajanje Partije (Session Length)**: **10 - 15 minuta**.
    *   30 minuta (standard za PC Vampire Survivors) je predugo za telefon (baterija, pažnja).
    *   Predlog: **15 minuta max** (ili 10 minuta + 5 minuta "Overtime").

## 5. Plan Sadržaja (Baza Neprijatelja i Oružja)

### Plan Neprijatelja (Enemies)
Cilj: **8-10 Tipova Neprijatelja + 3 Boss-a**.

**Tier 1: Fodder (Topovsko meso)**
1.  **Worm (Crvić)** [Implemented]: Spor, ide pravo na igrača. Služi za farming.
2.  **Slime (Sluz)**: Ostavlja usporavajuću sluz za sobom.

**Tier 2: Rushers (Brzi)**
3.  **Ghost (Duh)** [Implemented]: Brz, prolazi kroz zidove/prepreke.
4.  **Bat (Slepi Miš)**: Leti u "cik-cak" putanji, teško ga je pogoditi.

**Tier 3: Tanks (Otporni)**
5.  **Golem / Big Head**: Spor, velik HP, otporan na knockback.
6.  **Shield Skeleton**: Ima štit koji blokira projektile spreda.

**Tier 4: Ranged (Dalekometni)**
7.  **Spitter Plant**: Stoji u mestu i pljuje projektile.
8.  **Archer**: Beži od igrača i gađa strelama.

**Tier 5: Special (Specijalci)**
9.  **Exploder**: Eksplodira kad priđe blizu (Area Damage).
10. **Summoner**: Stvara nove Fodder neprijatelje dok se ne ubije.

**Bosses**
1.  **Giant Floating Head** [Implemented - Basic]: Prvi boss, samo juri. Treba mu dodati Dash napad.
2.  **Chromatic Golem**: Menja boje/otpornosti.
3.  **The Void Lord**: Finalni boss, Bullet Hell mehanike.

---

### Plan Oružja (Weapons)
Cilj: **6-8 Oružja**.

**Melee (Bliska borba)**
1.  **Hammer** [Implemented]: Kružni udarac (Orbit). Dobar za odbranu.
2.  **Sword**: Zamah ispred igrača (Cone). High damage, directional.
3.  **Spear**: Ubada pravo ispred (Thrust). Prolazi kroz više neprijatelja (Pierce).

**Projectile (Projektili)**
4.  **Axe** [Implemented]: Leti u luku (Boomerang).
5.  **Magic Wand**: Gađa najbližeg neprijatelja (Auto-target). Brza paljba.
6.  **Crossbow**: Gađa u smeru kretanja/miša (Manual/Linear). High crit.

**Area / Passive (Područje)**
7.  **Garlic / Aura**: Oštećuje sve u krugu oko igrača konstantno.
8.  **Molotov / Holy Water**: Baca zonu na pod koja pravi štetu vremenom (DoT).

## 6. Skalabilnost i Budući Update-ovi (Best Practices)
Da bi igra živela dugo na mobilnim marketima, **Sistem Etapa (Stages/Biomes)** je bolji od jednog beskonačnog nivoa.

*   **Zašto Etape (Stages)?**
    *   Omogućavaju jasan osećaj napretka ("Prešao sam Šumu, sad sam u Groblju").
    *   Lakše se dodaje sadržaj kroz update-ove (Novi Stage = Nova grafika + Novi neprijatelji).
    *   Omogućavaju različitu težinu (Stage 1: Easy, Stage 5: Hard).

*   **Plan za Update-ove**:
    1.  **Stage 1 (MVP)**: "The Dark Forest" (Osnovna tema).
    2.  **Budući Update-ovi**:
        *   Teme: "Haunted Castle", "Toxic Sewers".
        *   Svaka tema donosi jedinstvene zamke ili buff-ove.
    3.  **Endless Mode**: Otključava se nakon prelaženja svih etapa, za igrače koji žele samo high-score na jednoj mapi.
