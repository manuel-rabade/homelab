#!/bin/bash
# config-audio.sh — Sets master output volume AND resets the rt5616 codec
# to a clean baseline (disables capture, line-out off, saves asound.state).
# NanoPC-T6 LTS, kernel 6.12 — rear 3.5mm jack into external amplifier.
#
# DAC1 is the real master volume. Volume is a percentage (0-100) passed
# straight to ALSA, which maps it to the codec's native dB scale.
# Note: below ~30% this chip is barely audible; use the amp for fine low-end.
#
# Usage:
#   ./config-audio.sh        # default 75%
#   ./config-audio.sh 60     # 60%

CARD=0
HP_VOL=30             # HP stage: fixed, kept open (DAC controls level)
VOL_PCT="${1:-60}"    # master volume percentage; arg $1 or default 75
set -e

# Validate percentage (0-100)
if ! [[ "$VOL_PCT" =~ ^[0-9]+$ ]] || [ "$VOL_PCT" -gt 100 ]; then
    echo "!! Invalid volume '$VOL_PCT'. Must be an integer 0-100 (percent)." >&2
    exit 1
fi

echo ">> Master volume: ${VOL_PCT}% (ALSA native scale)"

echo ">> ===== OUTPUT (playback) ====="
# Master DAC — percentage handed directly to ALSA
amixer -c $CARD set 'DAC1' "${VOL_PCT}%" >/dev/null
# HP = jack output stage — kept open at a fixed level
amixer -c $CARD set 'HP' "$HP_VOL,$HP_VOL" on >/dev/null
# HP output routing switches (must be on)
amixer -c $CARD set 'HPVOL' on >/dev/null
amixer -c $CARD set 'HPO MIX DAC1' on >/dev/null
amixer -c $CARD set 'HPO MIX HPVOL' on >/dev/null
# DAC -> output mixers
amixer -c $CARD set 'Stereo DAC MIXL DAC L1' on >/dev/null
amixer -c $CARD set 'Stereo DAC MIXR DAC R1' on >/dev/null

echo ">> ===== LINE OUT (unused) ====="
# OUT off: not the jack output on this board
amixer -c $CARD set 'OUT' 0,0 off >/dev/null

echo ">> ===== INPUT / CAPTURE (disable) ====="
amixer -c $CARD set 'ADC' 0,0 off >/dev/null
amixer -c $CARD set 'ADC Boost' 0,0 >/dev/null
amixer -c $CARD set 'IN' 0,0 >/dev/null
amixer -c $CARD set 'IN1 Boost' 0 >/dev/null
amixer -c $CARD set 'IN2 Boost' 0 >/dev/null
# Turn off recording mixer switches (dead capture path)
for ctl in \
  'RECMIXL BST1' 'RECMIXL BST2' 'RECMIXL INL1' \
  'RECMIXR BST1' 'RECMIXR BST2' 'RECMIXR INR1' \
  'Stereo1 ADC MIXL ADC1' 'Stereo1 ADC MIXR ADC1' \
  'OUT MIXL REC MIXL' 'OUT MIXR REC MIXR' \
  'DAC MIXL Stereo ADC' 'DAC MIXR Stereo ADC'; do
    amixer -c $CARD set "$ctl" off >/dev/null 2>&1 || true
done

echo ">> ===== Saving baseline ====="
sudo alsactl store

echo ""
echo ">> Final output state:"
amixer -c $CARD sget 'DAC1' | grep -E 'Front (Left|Right)'
amixer -c $CARD sget 'HP'   | grep -E 'Front (Left|Right)'

echo ""
echo ">> Sound test (Front Center x3)..."
sleep 1
for i in 1 2 3; do
    aplay -D plughw:$CARD,0 /usr/share/sounds/alsa/Front_Center.wav 2>/dev/null
done
echo ">> Done."
