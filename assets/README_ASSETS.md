Asset structure and naming guide
================================

Top-level buckets (all under `assets/`):
- `player/` – Player sprites, animations, SFX.
- `enemies/` – Shared enemy art in `common/`, plus per-enemy subfolders when added.
- `bullets/` – Generic projectile sprites (bullets/beams), muzzle flashes.
- `abilities/` – Icons, projectile art, VFX, and SFX per ability.
- `pickups/` – Powerups/XP orbs, with icons, VFX, SFX.
- `fx/` – Reusable particles/textures (explosions, impacts, trails).
- `ui/` – Icons, fonts, UI VFX/SFX.
- `environment/` – Tilesets, tilemaps, props.
- `audio/` – Music/SFX not tied to one entity.
- `meta/` – Design docs, balance sheets, ability configs, thumbnails.

Suggested naming
- Use snake_case and prefix by type: `player_idle.png`, `enemy_grunt_run.png`, `bullet_basic.png`, `ability_dash_icon.png`, `pickup_xp_orb.png`.
- Exported sprite sheets: `*_sheet.png` + accompanying `.tres`/`.res` for AnimatedSprite2D/SpriteFrames.
- Particles/VFX: `fx_explosion_sm.png`, `fx_hit_spark.png`, `fx_trail_basic.png`.
- Audio: `sfx_shoot_basic.wav`, `sfx_enemy_die_01.wav`, `music_loop_01.ogg`.
- UI: `ui_button_default.png`, `ui_joystick_base.png`, `ui_joystick_handle.png`.

Future scaling (abilities/variants)
- Create per-ability subfolders under `abilities/` (e.g. `abilities/laser/`, `abilities/boomerang/`) holding `icons/`, `projectiles/`, `vfx/`, `sfx/` as needed.
- For new enemies, add `enemies/<enemy_name>/` with `sprites/`, `sfx/`, and reuse `enemies/common/` for shared pieces (blood, hit flashes).
- Keep `meta/` for balance sheets (CSV/JSON) that your scripts can load to drive ability parameters.

Import tips
- Set `Filter`/`Mipmap` per art style; for crisp pixel art disable filter & mipmaps in the import tab.
- For UI elements, enable `Repeat` only if you need 9-slice/stretching.
- For sounds, import as `WAV` when you need minimal latency (SFX), `OGG` for music/long loops.
