#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

# Default APK path (override by passing a path as first arg)
APK_PATH="${1:-$REPO_ROOT/BUILD/Android/MonsterChromatic.apk}"

if [[ ! -f "$APK_PATH" ]]; then
	# Fallback: last built debug APK from Godot Gradle path
	if [[ -f "$REPO_ROOT/android/build/build/outputs/apk/standard/debug/android_debug.apk" ]]; then
		APK_PATH="$REPO_ROOT/android/build/build/outputs/apk/standard/debug/android_debug.apk"
	fi
fi

if [[ ! -f "$APK_PATH" ]]; then
	echo "APK not found. Checked: $APK_PATH" >&2
	echo "Tip: export APK or pass path: bash scripts/install_android_apk.sh /full/path/to/app.apk" >&2
	exit 1
fi

if ! command -v adb >/dev/null 2>&1; then
	echo "adb not found in PATH. Install Android platform-tools and ensure adb is available." >&2
	exit 1
fi

if ! adb get-state >/dev/null 2>&1; then
	echo "No device detected. Enable USB debugging and connect a device (or start an emulator)." >&2
	adb devices
	exit 1
fi

echo "Installing $APK_PATH to connected device..."
adb install -r "$APK_PATH"
echo "Done."
