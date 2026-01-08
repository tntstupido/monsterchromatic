# MonsterChromatic: Art & Style Guide

Ovaj dokument služi kao centralni vodič za vizuelni stil, atmosferu, zvučni identitet i narativni ton igre.

## 1. Vizuelni Stil (Visual Style)
Cilj je "Sarcastic Horror" – spoj mračnog, ozbiljnog okruženja i apsurdnih, ekspresivnih karaktera.

### Karakteri (The "Bean" Style)
*   **Oblici**: Minimalistički, zaobljeni oblici bez udova (bean/blob).
*   **Tekstura**: Ručno crtana (hand-painted) sa vidljivim potezima četkice i jakim crnim konturama.
*   **Boje**: Mrtve, zemljane nijanse (beige, braon, siva) inspirisane postojećim asetima.

![Top-Down Concept](file:///home/mladen/Unreal/Godot/Projects/MonsterChromatic/Documents/Images/top_down_concept.png)

### Animacija
*   **Wobble Movement**: Proceduralna animacija (Tilt, Bounce, Squash & Stretch) umesto klasičnog hodanja.
*   **Ekspresivnost**: Velike, promenljive oči koje prenose emocije (strah, bes, sarkazam).

---

## 2. Dinamički UI i Atmosfera

### Sarkastični Speech Bubbles
Oblačići koji omogućavaju neprijateljima da komuniciraju sa igračem na ciničan način.

*   **Tehnika**: **Proceduralno crtanje** (GDScript `_draw`). Ivice oblačića stalno blago "vibriraju" (shaky effect) u realnom vremenu, što im daje živost i unikatnost.
*   **Ton**: Cinični komentari (Primer: "Nice miss!", "Is that all?", "Zzz...").

### Narativni Ton
*   **Cinični UI**: Opisi predmeta i poruke na ekranima koje ismevaju igračevu šansu za preživljavanje.
*   **Primer**: Umesto samo "Level Up", koristimo "Prolonging the inevitable".

### Shop Screen UI ("The Crypt") - ✅ IMPLEMENTIRANO
*   **Status**: Potpuno implementirano 2026-01-08 ([Detaljna dokumentacija](ShopScreenUI/implementation_summary.md))
*   **Koncept**: Prodavnica je "klopka" ili grobnica sa ciničnim prodavcem.

#### Shopkeeper Karakter
*   **Dizajn**: Hooded merchant sprite sa kesom novca (`shop_keeper_character.png`)
*   **Veličina**: 192x192 piksela, pozicioniran na vrhu ekrana
*   **Animacije**:
    *   **Continuous Wobble**: Konstantna 1.05x0.95 ↔ 0.95x1.05 scale loop animacija
    *   **Click Reactions** (3 tipa):
        *   **Wiggle**: -5° → +5° → 0° rotacija (left-right shake)
        *   **Bounce**: Squash & stretch sa TRANS_BACK easing
        *   **Shrug**: 15° rotacija + 10px pokret nagore
*   **Interakcija**: Clickable sa 0.5s cooldown-om između klikova
*   **Sarkastični Komentari**: 16 ciničnih komentara koji se rotiraju na klik
    *   Primeri: "Pick your poison.", "It won't help anyway.", "Death is patient. I'm not."
*   **Speech Bubble**: Persistent mode (ne nestaje automatski), sa shaky effect-om

#### Upgrade Kartice
*   **Layout**: 2x2 grid (4 kartice) optimizovan za portrait mobile
*   **Veličina**: 280x380 piksela (40% veće za mobile visibility)
*   **Texture System**: 8 texture varijanti sa random selekcijom:
    *   6 paper tekstura (torn parchment look)
    *   2 metal teksture (rusted plates)
*   **Ivice**: Jagged/torn edges iz texture asset-a (ne proceduralno)
*   **Ikonice**: 120x120 piksela, AI-generisane (Gemini) sa thick black outlines
    *   `health_icon.png` - Cross/plus symbol
    *   `speed_icon.png` - Lightning bolt
    *   `axe_icon.png` - Throwing axe
    *   `hammer_icon.png` - War hammer
*   **Tipografija**:
    *   Title: 26px black text, centered
    *   Description: 18px near-black text, centered with word wrap
*   **Padding**: 20px na sve strane da tekst ne prelazi jagged edges
*   **Interakcija**: Hover efekti (scale + wobble) za feedback

#### Mobile Optimization
*   **Target Platforms**: iPhone, Android phones, tablets
*   **Aspect Ratios**: Testirano na 9:16, 9:19.5, 9:20, 3:4
*   **Spacing**: 40px gap između kartica (comfortable touch targets)
*   **Testing Tool**: `ResolutionTester.gd` (F1 toggle) sa 6 preset rezolucija

---

## 3. Zvučni Identitet (Audio & SFX) - *[U pripremi]*
*   **Ambijent**: Mračni, niski tonovi, zvuk vetra i udaljenih krika.
*   **SFX**: "Slapstick" zvuci za kretanje (squish, wobble) i komični, prenaglašeni krici neprijatelja.

---

---

## 5. Okruženje (Environment)
Cilj je sumoran "Graveyard/Wasteland" stil koji se oseća kao da je nacrtan na starom, prljavom papiru.

### Stil Terena (Tilemap)
*   **Boje**: Tamno siva, isprana zelena (dead grass) i prljavo braon.
*   **Detalji**: Pukotine u zemlji, kosti i kamenje treba da budu deo tekstura tilemap-a.

### Dinamični Objekti (Props)
*   **Y-Sorting**: Svi objekti (nadgrobni spomenici, drveće) moraju koristiti Y-sorting kako bi igrač mogao da prolazi ispred i iza njih.
*   **Interactive Wobble**: Objekti nisu statični. Ako ih igrač udari ili prođe blizu njih, oni treba blago da "zadrhte" (procedural wobble), slično kao i karakteri.
*   **Primer**: Mrtvo drveće koje se blago njiše kada ga promašiš čekićem.
