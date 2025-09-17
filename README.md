# Algorithm Visualizer

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

Flutter Algorithm Visualizer — Prototype
File: main.dart

## How to run
1. Create a new Flutter project: flutter create algo_visualizer
2. Replace lib/main.dart with this file's contents
3. flutter run

## What this prototype contains
- Visualizes: Merge Sort, Quick Sort (array bars) and Rabin-Karp (string search)
- Controls: select algorithm, generate array/text, play/pause, step back/forward, speed slider, array size
- Implementation approach: each algorithm "records" a list of frames (snapshots). The UI steps through these frames to show the algorithm's progress. Each frame optionally marks indices being compared/swapped so the UI can highlight them.

## Step-by-step explanation (high-level)
1. Data model
   - Frame: snapshot of array + metadata (indices being compared/swapped + operation label).
   - RKFrame: snapshot for Rabin-Karp showing current shift index and the calculated hashes.

2. Algorithm instrumentation
   - Merge sort and Quick sort functions operate on a mutable copy of the array and add Frame objects to a List<Frame> whenever they compare or write values.
   - Rabin-Karp calculates rolling hashes and records an RKFrame for each shift (plus match check frames where necessary).

3. UI playback
   - The frames list becomes the timeline. A Timer drives playback (play/pause). A step-forward/backward button moves the current index manually.
   - The visualization area draws bars for sorting (height proportional to value). For RK a text view highlights the current window and shows pattern/hash info.

## Legend used in the UI
- Orange (compare): indices currently being compared.
- Red (swap): indices that were swapped.
- Green (match - Rabin-Karp): current window matched the pattern.

## Limitations & notes
- This is a compact prototype aimed at clarity. For production you'd split into files and add tests.
- Very large array sizes will create many frames and can use lots of memory — keep size under ~120 for smooth performance.

