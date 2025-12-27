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
