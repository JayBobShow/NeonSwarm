# Neon Swarm Phase 41 Opening Intro Sequence Report

## Scope

Phase 41 adds the first real opening intro sequence for Neon Swarm. It is a
short, skippable story-panel intro that uses the Phase 40 story bible names and
hands off into the existing gameplay flow in `scenes/Main.tscn`.

This phase does not start Phase 42, does not build the ending sequence, does not
create an alternate playable scene, and does not change gameplay balance.

## Runtime Integration

- The intro overlay is built inside `scripts/NeonSwarm3DGameplayPrototype.gd`
  as `OpeningStoryIntroOverlay`.
- The existing title menu remains the entry point.
- Selecting `START GAME` starts the intro the first time in the current app
  session.
- When the intro finishes or is skipped, the existing start-run path resumes.
- Gameplay, player movement, collision, hurtbox behavior, weapons, sectors,
  Armory, Forge, Evolution/Fusion, Neon Dust, and save data are not changed.

## Intro Panel Script

1. `THE LEGEND`
   `Long ago, the Neon Grid carried light between the stars.`
2. `THE FALL`
   `But beneath the Grid, an ancient silence woke.`
3. `THE NULL KING`
   `They called it the Null King - the Shape That Eats Stars.`
4. `THE SWARM`
   `Where its shadow touched, cities became empty geometry. Living light shattered into the Swarm.`
5. `THE LAST CORE`
   `One Aether Core still burned in the dark, carrying the lost soul of Nova Veyr.`
6. `LYRA'S SIGNAL`
   `Across the broken Grid, Lyra Quill found a signal that should have been impossible.`
7. `AWAKENING`
   `Nova... wake up. The universe is not dead yet.`
8. `START`
   `The Aether Core ignites.`

## Presentation

- Dark full-screen background.
- Subtle memory-star and slow rift-line motion.
- Centered framed text panel with large readable title/body text.
- Small panel counter.
- Skip prompt: `PRESS ANY KEY / A TO SKIP`.
- Fade in/out timing between story panels.
- Phase 40 tagline is shown as a small lower-screen anchor:
  `ONE LIGHT. ENDLESS SWARM. A UNIVERSE WORTH REMEMBERING.`

## Skip Behavior

The intro can be skipped with:

- Keyboard press.
- Controller button press.
- Mouse button press.
- Existing confirm/cancel/pause input actions.

Skipping hides the intro overlay, unpauses the tree, and resumes the existing
gameplay start flow.

## Music And Audio

Phase 41 adds a new original procedural music state named `intro`.

The intro loop uses the existing in-project procedural audio generator with a
slower tempo and darker mix than gameplay:

- Tempo: 78 BPM.
- Length: 10 seconds.
- Root pitch: 49 Hz.
- Mix target: dark pad, restrained bass, low arpeggio motion, minimal kick/hat.

No external copyrighted music or imported audio is used.

## Limitations

- The intro is text-panel based, not a full cinematic system.
- It plays once per app session before the first title-menu start.
- There is no persistent "has seen intro" save flag yet.
- There is no voice acting.
- There is no ending sequence in this phase.

## Manual Test Checklist

- Launch `scenes/Main.tscn`.
- Select `START GAME` from the title menu.
- Confirm the intro appears before gameplay.
- Confirm all eight panels are readable and in order.
- Confirm music plays during the intro.
- Confirm keyboard skip works.
- Confirm controller skip works.
- Confirm skip enters gameplay.
- Confirm letting the final panel complete enters gameplay.
- Confirm the official scene path remains `scenes/Main.tscn`.
- Confirm no ending sequence appears.
