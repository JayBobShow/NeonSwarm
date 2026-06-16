# Neon Swarm Phase 9 Geometry Shape Audit

## Scope

This audit covers the active official game only.

Official build source:

- `project.godot` launches `res://scenes/Main.tscn`.
- `scenes/Main.tscn` uses `scripts/NeonSwarm3DGameplayPrototype.gd`.
- The official gameplay script preloads the live visual scene assets from `scenes/visuals/*.tscn`.
- The visual scene files are script-backed `Node3D` roots using `scripts/visuals/*.gd`.
- HUD motifs come from `scripts/ui/NeonHudPanel.gd` and `scripts/ui/NeonSegmentGauge.gd`.

This is a source audit, not a live screenshot review. It lists rendered geometry and gameplay collision geometry currently used by the official build after the Phase 9 shape updates now present in `scripts/visuals/*.gd`.

## Short Summary

Phase 9 resolved several previously weak silhouettes by adding role-specific geometry:

| Object | Phase 9 Shape Change | Current Recommendation |
| --- | --- | --- |
| Player Core | Added forward command prow, cyan command chevrons, and magenta delta wings. | Keep |
| Tank | Added side tread armor slabs, forward siege plow, and rear counterweight. | Revised, keep |
| Shooter | Added split cannon rails and raised targeting crest. | Keep |
| Exploder | Added pressure fuse, vent nozzle, and six raised pressure charges. | Revised, keep |
| Spiral Drifter | Added cyan/violet sail blades with white-hot sail edges. | Keep |
| Shield Node | Added hexagonal ward core plate and forward hex shield face. | Revised, keep |
| Prism Warden | Added command shoulder fins, floating hex command crown, crown spires, and crown beacons. | Revised, keep |
| XP Pickup | Added gold hex coin backplate and white-hot XP plus glyph. | Revised, keep |

The strongest current shape identities are the Player Core, Chaser, Tank, Shooter, Spiral Drifter, Shield Node, Prism Warden, XP pickup, Nova Burst, Gravity Mine, Ring Saw, and the upgraded HUD panels.

Remaining future risks:

| Risk Area | Current Issue | Recommendation |
| --- | --- | --- |
| Pulse Blaster projectile | Still a cyan capsule bolt and still close in primitive language to the enemy energy bolt. | Revise into a more player-owned faceted streak or needle. |
| Prism Lance | Still mostly a violet tube with one annulus, so the weapon name promises more prism language than the render provides. | Add triangular or hexagonal prism facets while preserving speed readability. |
| Torus/ring reuse | Player, Exploder, Shield Node, Prism Warden, XP, Orbit Spark, Nova, Gravity Mine, Ring Saw, and bursts all use annuli. | Keep using rings, but preserve distinct scale, orientation, color, and motion per role. |
| Hex motif growth | Shooter, Shield Node, Prism Warden crown, and XP coin now all use hexagonal forms. | Keep, but avoid making every future object hex-based. |
| Upgrade choices | Upgrade metadata declares shapes, but the level-up UI still shows text-only cards. | Add procedural shape icons or treat the metadata as internal design notes only. |

## Active Object Shape Audit

| Classification | Asset / Game Object | Source | Primary Geometry | Secondary Geometry / Accents | Collision / Gameplay Shape | Recommendation | Art Direction Note |
| --- | --- | --- | --- | --- | --- | --- | --- |
| Player | Player Core, `PlayerGameplayArea3D` with `Player3DVisualAsset` | `scripts/NeonSwarm3DGameplayPrototype.gd`, `scripts/visuals/Player3D.gd`, `scenes/visuals/Player3D.tscn` | Scaled octahedron / diamond command body. | Counter-rotated magenta octahedron, spherical plasma shells, white-hot sphere reactor, white-hot forward command prow capsule, cyan chevron tube frame with white-hot cores, magenta triangular-prism delta wings, three torus shield rings, octahedron tube edges, ghost smear tubes, orbiting spark spheres. | Sphere collision, `PlayerCollisionSphere`. | Keep | Phase 9 improves directional read and command silhouette. Future risk is visual density around the player; keep the prow/chevrons/wings crisp and avoid adding more player rings. |
| Enemy | Chaser | `scripts/NeonSwarm3DGameplayPrototype.gd`, `scripts/visuals/Chaser3D.gd`, `scenes/visuals/Chaser3D.tscn` | Forward triangular pyramid / tetrahedron arrow. | Thin matching plasma shell, glowing tetrahedron edge tubes, white-hot attack nose sphere, triangular-prism rear fins, ventral knife keel fin, forward raking talon tubes, white-hot center needle ridge, rear ion sphere, wake tubes, corner spark spheres. | Sphere collision, `EnemyCollisionSphere`. | Keep | Excellent pursuit silhouette. Added keel/talon detail reinforces aggression without changing the readable primary arrow. |
| Enemy | Tank | `scripts/NeonSwarm3DGameplayPrototype.gd`, `scripts/visuals/Tank3D.gd`, `scenes/visuals/Tank3D.tscn` | Heavy cuboid / rectangular-prism armored mass. | Rectangular heat haze shell, left/right side tread armor slabs, forward orange siege plow, rear gold engine counterweight, box edge tubes, internal diagonal load-bearing cross tubes, white-hot sphere reactor, corner pylon spheres, cylinder pylon caps. | Sphere collision, `EnemyCollisionSphere`. | Revised, keep | Phase 9 fixes the generic-box problem. The tank now has a front, side armor, and rear mass. Future risk: side slabs and plow are still box-family primitives, so avoid letting it flatten into a plain block at gameplay distance. |
| Enemy | Shooter | `scripts/NeonSwarm3DGameplayPrototype.gd`, `scripts/visuals/Shooter3D.gd`, `scenes/visuals/Shooter3D.tscn` | Hexagonal prism artillery body. | Hex prism tube edges, forward white-hot capsule aim spine, paired cyan split cannon rails, raised violet targeting crest box, white-hot targeting crest line, charged muzzle sphere shell, white-hot muzzle sphere, torus focus ring, spark spheres. | Sphere collision, `EnemyCollisionSphere`. | Keep | Stronger ranged read after Phase 9. Split rails and targeting crest distinguish it from generic orb/muzzle enemies. |
| Enemy | Exploder | `scripts/NeonSwarm3DGameplayPrototype.gd`, `scripts/visuals/Exploder3D.gd`, `scenes/visuals/Exploder3D.tscn` | Unstable pressure sphere body. | Red/orange spherical plasma shells, white-hot overload sphere, top orange fuse capsule, white-hot fuse tip sphere, bottom white-hot vent cylinder, six raised orange pressure-charge boxes, three warning torus rings, radial warning spike tubes, leaking spark spheres. | Sphere collision, `EnemyCollisionSphere`. | Revised, keep | Phase 9 gives the Exploder a clear bomb/pressure identity beyond a red sphere. Future risk: from high camera distance, the sphere still dominates, so fuse/charges should remain bright and visible. |
| Enemy | Spiral Drifter | `scripts/NeonSwarm3DGameplayPrototype.gd`, `scripts/visuals/SpiralDrifter3D.gd`, `scenes/visuals/SpiralDrifter3D.tscn` | Spheroid core wrapped by double helix tubes. | Controlled spheroid haze, white-hot core point, cyan/violet triangular-prism drift sail blades, white-hot sail edge tubes, cyan primary helix tube, white-hot helix core, violet secondary helix, upper/lower annuli, helix edge spark spheres. | Sphere collision, `EnemyCollisionSphere`. | Keep | Phase 9 sail blades improve lateral silhouette while preserving the helix identity. Future risk is clutter if sails and helix overlap too tightly in motion. |
| Enemy | Shield Node | `scripts/NeonSwarm3DGameplayPrototype.gd`, `scripts/visuals/ShieldNode3D.gd`, `scenes/visuals/ShieldNode3D.tscn` | Hex ward shield core over protected spheroid. | Spheroid body, hexagonal ward core plate, glowing hex ward edge tubes, spherical plasma shell, white-hot protected sphere, forward hex shield face assembly, blue primary annulus, white-hot annulus core, vertical cyan torus shield ring, radial spoke tubes, spark spheres. | Sphere collision plus shield HP state, `EnemyCollisionSphere`. | Revised, keep | Phase 9 solves the generic orb-with-rings problem. The forward hex face now communicates shielding. Future risk: hex forms overlap Shooter and XP, so keep the Shield Node blue/defensive and front-facing. |
| Boss | Prism Warden / `MiniBoss3D` | `scripts/NeonSwarm3DGameplayPrototype.gd`, `scripts/visuals/MiniBoss3D.gd`, `scenes/visuals/MiniBoss3D.tscn` | Large violet octahedron command body. | Octahedron plasma shell, octahedron neon edge tubes, white-hot command sphere, white-hot vertex beacon spheres, magenta triangular-prism command shoulder fins, floating hex command crown plate, glowing hex crown edge tubes, six cylinder crown spires, six white-hot crown beacon spheres, three reactor torus rings, crown spark spheres. | Sphere collision, `EnemyCollisionSphere`. | Revised, keep | Phase 9 adds enough command/crown language to separate the Warden from the player and XP octahedra. Future risk: the octahedron core still overlaps the player shape family, so preserve boss scale and crown/fins as mandatory identity markers. |
| Pickup | XP pickup / `XPOrb3DGameplayPickup` | `scripts/NeonSwarm3DGameplayPrototype.gd`, `scripts/visuals/XPOrb3D.gd`, `scenes/visuals/XPOrb3D.tscn` | Gold hex coin reward backplate with faceted octahedron gem. | Hex prism coin plate, glowing hex coin edges, scaled gold octahedron reward facet body, controlled gold sphere halo, octahedron edge tubes, white-hot reward sphere, white-hot plus-glyph box strokes, cyan/gold/magenta orbit torus rings, green value glint torus, sparkle spheres, collection trail tube. | Sphere collision, `XPOrbCollisionSphere`. | Revised, keep | Phase 9 gives XP a pickup-specific coin and plus read instead of only a jewel/orb read. Future risk: coin/plus language can become too UI-like if it loses the neon body and plasma halo. |
| Projectile | Pulse Blaster projectile / `PulseBlaster3DProjectile` | `scripts/NeonSwarm3DGameplayPrototype.gd`, `scripts/visuals/Projectile3D.gd`, `scenes/visuals/Projectile3D.tscn` | Cyan capsule energy bolt. | Blue capsule haze, white-hot capsule needle core, two cylinder ghost trail tubes. | Sphere collision, `ProjectileCollisionSphere`. | Revise | Still readable but generic. It should get a more player-owned projectile silhouette to separate it from red enemy bolts. |
| Projectile | Prism Lance / `PrismLancePiercingProjectile` | `scripts/NeonSwarm3DGameplayPrototype.gd` | Long violet neon tube. | White-hot tube core and forward stabilizer annulus. | Sphere collision, `PrismLanceCollisionSphere`. | Revise | Still the weakest name-to-shape match. Add triangular or hexagonal prism facets while keeping the fast lance read. |
| Projectile | Enemy energy bolt / `EnemyEnergyBolt3D` | `scripts/NeonSwarm3DGameplayPrototype.gd` | Red capsule bolt. | White-hot capsule core. | Sphere collision, `EnemyProjectileCollisionSphere`. | Keep | Color separates it from player fire, but it remains primitive-adjacent to Pulse Blaster. If player fire becomes faceted, enemy bolts can stay capsule-based. |
| Projectile | Orbit Spark weapon / `OrbitSparkWeaponVisuals` | `scripts/NeonSwarm3DGameplayPrototype.gd` | Orbiting sphere node. | White-hot sphere core, cyan sphere shell, torus annulus trace. | No Area3D projectile; damage checks use orbit radius against enemy collision radius. | Keep | Clear radial weapon identity. Watch overlap with Shield Node and XP orbit rings. |
| Projectile | Nova Burst weapon / `NovaBurstExpandingTorus` | `scripts/NeonSwarm3DGameplayPrototype.gd` | Expanding torus / annulus shockwave. | White-hot torus core, magenta outer accent annulus, color-matched burst rings from `_spawn_burst`. | No collision node; radial damage check uses `NOVA_RADIUS`. | Keep | Strong area-of-effect read and aligned with the shape bible's annulus/radial burst assignment. |
| Projectile | Arc Beam weapon / `ArcBeamChainEffect` | `scripts/NeonSwarm3DGameplayPrototype.gd` | Straight cylinder/tube beam segment. | Cyan outer beam tube and white-hot core tube chained between targets. | No collision node; target selection uses chain range and enemy indices. | Keep | Good high-speed readability. It is correctly a transient VFX object rather than a persistent projectile mesh. |
| Projectile | Gravity Mine / `GravityMineGameplayArea` | `scripts/NeonSwarm3DGameplayPrototype.gd` | Torus / gravity-well annuli. | White-hot sphere core, purple torus body, larger pull-field annulus. | Sphere influence collision, `GravityMineInfluenceSphere`. | Keep | Clear mine/well identity. Good separation from Ring Saw through scale and placement. |
| Projectile | Ring Saw weapon / `RingSawNeonTubeWeaponVisual` | `scripts/NeonSwarm3DGameplayPrototype.gd` | Large torus / annular blade field. | Cyan outer torus, white-hot inner torus, violet offset cutter torus. | No collision node; damage checks compare enemy distance to saw radius and width. | Keep | Strong weapon silhouette. It should stay distinct from Nova by being persistent, spinning, and closer to the player. |
| UI motif | HUD panels / `NeonHudPanel` | `scripts/NeonSwarm3DGameplayPrototype.gd`, `scripts/ui/NeonHudPanel.gd` | Chamfered octagonal 2D panel polygon. | Cyan/magenta tube-like polylines, inner inset polygon, diagonal corner line tubes, dark glass fill. | UI only. | Keep | Strong cover-art HUD language. It avoids plain rectangles and gives the official build a coherent interface motif. |
| UI motif | Segment gauges / `NeonSegmentGauge` | `scripts/NeonSwarm3DGameplayPrototype.gd`, `scripts/ui/NeonSegmentGauge.gd` | Angled 2D bar polygon. | Filled angled polygon, outline polyline, six segment divider lines. | UI only. | Keep | Good compact gauge shape. It matches the angular HUD panels without cluttering the playfield. |
| UI motif | Upgrade choice buttons | `scripts/NeonSwarm3DGameplayPrototype.gd` | Rectangular UI buttons with asymmetric rounded corners. | Neon border style, focus/hover glow, text-only upgrade presentation. | UI only. | Revise | Upgrade data includes shape names, but the UI does not render those shapes. Add small procedural geometry icons for art-direction consistency. |
| VFX motif | Death, hit, shield, XP, damage, sector-clear burst / `GameplayDeathOrImpactBurst3D` | `scripts/NeonSwarm3DGameplayPrototype.gd` | Sphere pop plus concentric torus rings. | White-hot snap ring, plasma ring, color-matched flash ring, magenta accent ring, capsule spark fragments, triangular prism shard fragments. | VFX only. | Keep | Strong short-lived arcade burst. Uses caps and lower counts under high load. |
| VFX motif | XP attraction trail / `XPCollectionEnergyTrail` | `scripts/NeonSwarm3DGameplayPrototype.gd` | Dynamic cylinder tube. | Gold emissive trail radius scales with pickup pull strength. | VFX only. | Keep | Functional and readable. It should stay capped because many pickups can exist. |
| VFX motif | Player and projectile ghost trails | `scripts/visuals/Player3D.gd`, `scripts/visuals/Chaser3D.gd`, `scripts/visuals/Projectile3D.gd` | Cylinder/tube smears. | Blue/green haze materials, updated length/radius per frame. | VFX only. | Keep | Good motion read with low geometry complexity. |
| VFX motif | Low priority neon dust | `scripts/NeonSwarm3DGameplayPrototype.gd` | Small sphere multimesh particles. | Blue drifting spark field. | VFX only. | Keep | Acceptable background texture because it is low priority, batched, and visually small. |
| VFX motif | Arena grid and border | `scripts/NeonSwarm3DGameplayPrototype.gd` | Rectangular grid lines and rectangular border frame. | Minor/major/axis line surfaces, colored border tube edge mesh, white-hot border core. | Arena boundary is enforced by gameplay position clamps, not by mesh collision. | Keep | Matches the shape bible's arena assignment. Do not let grid brightness compete with enemy readability. |

## Shape Vocabulary Index

| Shape Primitive | Active Users | Classification Coverage | Recommendation |
| --- | --- | --- | --- |
| Octahedron / diamond | Player body and inner diamond, Prism Warden body/shell, XP gem core. | Player, boss, pickup. | Keep but ration. Phase 9 reduced overlap with added player wings, Warden crown/fins, and XP coin/glyph. |
| Tetrahedron / triangular pyramid | Chaser body and glowing edge frame. | Enemy. | Keep. It is a clear pursuit/threat shape. |
| Cuboid / rectangular prism / box | Tank body, Tank side tread slabs, Tank siege plow, Tank counterweight, Shooter targeting crest, Exploder pressure charges, XP plus glyph strokes, arena rectangular grid language. | Enemy, pickup, VFX motif. | Keep with control. Phase 9 made Tank's box-family language intentional, but future box use should not weaken Tank ownership. |
| Hexagonal prism | Shooter body, Shield Node ward core/forward shield face, Prism Warden command crown, XP coin backplate, declared Lance Aperture upgrade metadata. | Enemy, boss, pickup, UI motif metadata. | Keep with caution. Hexes are now a major Phase 9 motif; use color, scale, and orientation to keep roles separate. |
| Triangular prism | Player delta wings, Chaser rear fins and keel, Spiral Drifter sail blades, Prism Warden command shoulder fins, burst shard fragments, declared Vector Thrusters and Lance Refraction metadata. | Player, enemy, boss, VFX motif, UI motif metadata. | Keep. Triangular-prism fins now carry directionality and role language well. |
| Sphere | Player reactor, Chaser nose/wake, Tank reactor/pylons, Shooter muzzle, Exploder body/core/fuse tip, Spiral Drifter core, Shield Node protected core, Prism Warden beacons, XP halo/core, Orbit Spark, Gravity Mine core, burst pop, dust, spark batches, all gameplay collision shapes. | All classifications except UI motif. | Keep as support geometry. Avoid returning to sphere-as-primary for future enemies unless supported by stronger structural accents. |
| Spheroid / ellipsoid | Spiral Drifter body/haze, Shield Node protected core/haze. | Enemy. | Keep. Phase 9 additions make these support forms instead of the whole identity. |
| Capsule | Player command prow, Shooter aim spine/rail/crest line, Exploder fuse, Pulse projectile, enemy projectile, burst spark fragments. | Player, enemy, projectile, VFX motif. | Revise projectile ownership only. Capsules work well as tubes/prows/fuses, but player and enemy bolts still need clearer separation. |
| Cylinder / tube | Neon edges, Chaser talons/ridge, Player chevrons, Spiral sail edges, Arc Beam, Prism Lance body/core, XP trail, pylon caps, Exploder vent, Prism Warden spires, HUD line motif through 2D draw lines. | Player, enemy, projectile, pickup, boss, UI motif, VFX motif. | Keep. Tubes remain the core neon gas-light construction primitive. |
| Torus / annulus / ring | Player shield rings, Shooter muzzle ring, Exploder warning rings, Spiral Drifter annuli, Shield Node rings, Prism Warden reactor rings, XP orbit rings, Orbit Spark trace, Ring Saw, Nova, Gravity Mine, burst rings. | Player, enemy, projectile, pickup, boss, VFX motif. | Keep but control reuse. Rings are strong but heavily used; each role needs unique scale, orientation, color, and motion. |
| Helix | Spiral Drifter double helix, declared Magnet Helix upgrade metadata. | Enemy, UI motif metadata. | Keep. This remains one of the most distinctive advanced shapes currently active. |
| Radial spokes / spikes | Shield Node spokes, Exploder warning spikes, Prism Warden crown spire circle. | Enemy, boss. | Keep. Phase 9 gives these shapes more explicit role context. |
| Chamfered 2D polygon | HUD panels, center panels, level-up panel. | UI motif. | Keep. Strong interface motif and not confused with gameplay objects. |
| Angled 2D bar polygon | Health, XP, boss gauges. | UI motif. | Keep. Supports compact HUD readability. |
| ImmediateMesh grid lines | Arena minor/major/axis grid. | VFX motif. | Keep. It is a background motif, not a gameplay object identity. |
| Dodecahedron | Declared `warden_cache` upgrade metadata only. | UI motif metadata. | Revise if exposed. It is not currently rendered, so it is not an active visual shape. |
| Pentagonal prism | Declared `reward_sieve` upgrade metadata only. | UI motif metadata. | Revise if exposed. It is not currently rendered, so it is not an active visual shape. |
| Cylinder capacitor / sphere reactor / annulus field / torus gyro metadata | Declared upgrade pool shape strings only. | UI motif metadata. | Revise. These shape labels should become visible procedural icons or be treated as internal design notes only. |

## Weapon And Projectile Class Notes

| Weapon / Projectile Class | Current Geometry | Recommendation | Direction |
| --- | --- | --- | --- |
| Pulse Blaster | Capsule bolt with capsule core and ghost tubes. | Revise | Give it a player-owned faceted streak, such as a small octahedron nose, triangular-prism dart, or chevron-linked tube trail. |
| Orbit Spark | Spherical node plus annulus trace. | Keep | Good orbiting weapon read. Avoid making Shield Node and XP orbit rings too similar in color/motion. |
| Nova Burst | Expanding torus shockwave plus burst rings. | Keep | Clear area weapon. Keep ring expansion short-lived and high contrast. |
| Arc Beam | Cyan and white-hot beam tubes chained between targets. | Keep | Strong chain lightning read without particle spam. |
| Gravity Mine | Sphere core with purple torus and pull-field annulus. | Keep | Strong field/well read. Good separation from Ring Saw through scale and placement. |
| Prism Lance | Violet tube, white-hot core, forward annulus. | Revise | Add prism facets so the visual matches the weapon name. |
| Ring Saw | Three torus rings around the player. | Keep | Strong persistent annular blade. Preserve its spinning motion as the main differentiator from Nova. |
| Enemy Energy Bolt | Red capsule with white-hot capsule core. | Keep | Readable hostile projectile. It can stay simple if Pulse Blaster receives the next projectile-shape pass. |

## Enemy And Boss Direction Notes

| Object | Recommendation | Direction |
| --- | --- | --- |
| Chaser | Keep | Preserve acute triangular-pyramid arrow language, rear fins, keel, talons, and needle ridge. |
| Tank | Revised, keep | Preserve side tread armor, siege plow, and rear counterweight; future edits should make the plow/treads read from the gameplay camera. |
| Shooter | Keep | Preserve hex-prism body, split rails, raised targeting crest, and charged muzzle assembly. |
| Exploder | Revised, keep | Preserve fuse, vent nozzle, pressure charges, warning torus rings, and radial spikes. |
| Spiral Drifter | Keep | Preserve helix identity and sail blades; make sure sails do not obscure the helix under motion. |
| Shield Node | Revised, keep | Preserve hex ward core and forward shield face; keep blue defensive read distinct from Shooter and XP hexes. |
| Prism Warden | Revised, keep | Preserve octahedron boss core, command fins, hex crown, spires, and beacons; these are now core boss identity markers. |

## UI And VFX Direction Notes

| Motif | Recommendation | Direction |
| --- | --- | --- |
| HUD angular panels | Keep | The chamfered polygon panels are a strong official-build style anchor. |
| Segment gauges | Keep | Compact and readable. Good reuse of angular UI language. |
| Level-up upgrade cards | Revise | The code stores shape names for upgrades but does not display shape icons. Add small procedural icons in a later UI pass if shape identity matters to choices. |
| XP pickup glyph | Revised, keep | The hex coin and plus glyph improve pickup readability. Keep it neon/plasma so it does not become a flat UI icon in-world. |
| Bursts | Keep | The sphere, torus, capsule spark, and triangular-prism shard recipe is strong and performance capped. |
| Arena grid/border | Keep | Fits the shape bible. Maintain lower brightness than player/enemy objects. |
| Atmosphere dust | Keep | Batched sphere dust is acceptable as low-priority plasma texture. |

## Highest Priority Improvements

1. Differentiate player Pulse Blaster from enemy energy bolts.
2. Add real prism facets to Prism Lance.
3. Add visible upgrade shape icons or stop treating upgrade `shape` metadata as an active art-direction promise.
4. Watch hex overuse after Shield Node, Prism Warden crown, XP coin, and Shooter all use hexagonal forms.
5. Watch torus/ring overuse across player, enemies, pickups, weapons, and bursts.
6. In live review, confirm Phase 9 small details remain readable from the official orthographic gameplay camera.

## Audit Limits

- This audit is based on source inspection, not rendered screenshots.
- It covers official `scenes/Main.tscn` only and does not audit archived or prototype scenes.
- `scenes/visuals/*.tscn` are minimal script-backed scene roots; the meaningful geometry is created procedurally in `scripts/visuals/*.gd`.
- Collision shapes are intentionally simpler than rendered geometry. Current gameplay uses sphere collision for player, enemies, pickups, projectiles, and mine influence.
