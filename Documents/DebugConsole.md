# Debug Console - Testing & Balancing Guide

Debug konzola omogućava brzo testiranje i balansiranje oružja i gameplay-a.

## Kako koristiti

Pokreni igru i koristi F-tastere tokom igranja:

### Komande

| Taster | Komanda | Opis |
|--------|---------|------|
| **F1** | Toggle God Mode | Besmrtnost - postavlja HP na 9999 |
| **F2** | Level Up Player | Daje 1000 XP (pokreće level up i shop screen) |
| **F3** | Spawn 10 Enemies | Spawnuje 10 neprijatelja u krugu oko igrača |
| **F4** | Add Random Weapon | Dodaje random weapon iz liste |
| **F5** | Heal Player | Leči igrača do maksimuma |
| **F6** | Show Weapon Stats | Prikazuje sve weapon stats u konzoli |
| **F7** | Toggle Debug Overlay | (Za buduću implementaciju - real-time stats) |
| **F8** | Toggle Verbose Mode | Uključi/isključi debug poruke u konzoli |

## Workflow za testiranje oružja

### 1. Testiranje Base Damage-a
```
1. Pokreni igru (F5)
2. F3 - Spawn enemies
3. Testiraj koliko brzo ubija neprijatelje
4. F6 - Proveri stats
5. Ponovi sa raznim oružjima (F4)
```

### 2. Testiranje Level Progression
```
1. F1 - God mode ON
2. F2 - Level up (više puta)
3. F6 - Proveri kako rastu stats
4. F3 - Spawn enemies da testiraš novi damage
```

### 3. Testiranje Weapon Kombinacija
```
1. F4 - Dodaj više različitih oružja
2. F2 - Level up svako oružje
3. F6 - Uporedi stats
4. F3 - Test protiv dummies
```

### 4. DPS Testing
```
1. F1 - God mode ON
2. F3 - Spawn 10 enemies
3. Pokreni štopericu (telefon/sat)
4. Izmeri vreme dok ne poubija sve
5. Kalkulacija: (10 enemies × enemy_hp) / vreme = DPS
```

## Balansiranje - Checklist

### Damage Balance
- [ ] Sve weapons bi trebalo da imaju sličan DPS na Level 1
- [ ] Melee weapons (Hammer, Prayer Beads) → Veći single-target damage
- [ ] Ranged weapons (Axe, Cross, Skull) → Bolji AOE/multi-target

### Progression Balance
- [ ] Level 5 weapon → ~2x jači od Level 1
- [ ] Level 10 weapon → ~3-4x jači od Level 1
- [ ] Svaki level treba da se "oseća" kao upgrade

### Weapon Uniqueness
- [ ] **Hammer**: Najjači single hit, AOE swing
- [ ] **Axe**: Boomerang pattern, dobro za kiting
- [ ] **Blessed Cross**: 4-way coverage, konstanta zaštita
- [ ] **Cursed Skull**: Homing + explosion, najbolji protiv tankova (radius raste sa levelom: 120px → 200px max)
- [ ] **Prayer Beads**: Continuous orbital damage, passive defense

## Trenutni Stats (za poređenje)

| Weapon | Starting Damage | Cooldown | Special |
|--------|----------------|----------|---------|
| Hammer | 40.0 | 1.2s | AOE swing |
| Axe | 15.0 | 0.8s | Returns |
| Blessed Cross | 12.0 | 1.0s | 4 projectiles |
| Cursed Skull | 25.0 + (18.75 AOE) | 1.5s | Homing + 75% explosion (120-200px) |
| Prayer Beads | 8.0 | 0.0s | 3 orbitals, continuous |

## Napomene

- Debug Console je automatski **disabled** u production buildovima
- Za disable tokom development-a, promeni `_enabled = false` u DebugConsole.gd
- Stats se prikazuju u Output konzoli (Alt+3 u editoru ili terminal ako pokreneš iz cmd)
- **Verbose Mode** je **OFF** po default-u da ne spamuje konzolu - pritisni F8 da uključiš
- Player dust spawn print je isključen da ne zagušuje konzolu

## Problemi i rešenja

**Q: F2 ne radi (Level Up)?**
A: Player mora imati `add_experience()` metod. Proveri da li je ExperienceManager povezan.

**Q: F3 ne spawn-uje enemies?**
A: Main.gd mora imati `spawn_enemy(scene, spawn_pos)` i `get_random_enemy_scene()` metode. ✅ Fixed!

**Q: F6 ne prikazuje ništa?**
A: Otvori Output konzolu u Godot editoru (Alt+3) ili pokreni igru iz terminala.
