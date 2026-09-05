# Nixos Config

Hi, I'm Tredddo. This repository contains the NixOS configuration I customized throughout this year. I'm sharing it in the hope that it provides useful insights or reference points for anyone exploring or configuring NixOS.

## Why NixOS?

I chose NixOS primarily because of its declarative and atomic nature:

- Atomic and Resilient Upgrades: Unlike traditional imperative distributions, interrupted updates do not break the system. Because generations are swapped atomically, brutally killing the build or update process leaves the current working environment untouched. (Distributions like openSUSE MicroOS / Aeon achieve something similar via transactional Btrfs snapshots, though I haven't personally tried them yet).

- Content-Addressed Local Caching: The Nix store caches downloaded dependencies and build artifacts incrementally. If a download or rebuild is stopped mid-way, already-fetched closures remain in /nix/store, meaning you don't have to restart the download process from scratch (my internet do not work well, so is very usefull).

- Declarative Reproducibility: Having the entire operating system, kernel modules, packages, and services described in code makes tracking system changes straightforward.

## Caveats & Resources

While Nix/NixOS offers great isolation and thorough community documentation, it is notably resource-heavy: storing multiple system generations and isolated dependency trees consumes substantial disk space (as detailed in the Btrfs notes below) and system resources during evaluation.

To find package names and system options compatible with your setup, refer to the official index: search.nixos.org

## Disclaimer & Known Issues

Disclaimer: This NixOS configuration is tailored specifically for a Gigabyte G6 KF laptop. It is provided "as is" for personal reference and will not be maintained or updated regularly. Use it at your own risk.

## Known Hardware & System Issues

- Built-in Keyboard lights: The integrated keyboard lights does not work. There is currently no upstream driver/kernel support for this specific model, and all workarounds attempted in this configuration have failed.

- NVIDIA Power Management: Experimental NVIDIA power management options are enabled to fix suspend/resume behavior. While tested and stable in this setup, they remain experimental in the nvidia upstream.

- Btrfs Metadata & Block Exhaustion (No space left on device): NixOS downloads numerous packages, hard links, and store references during builds and system upgrades. Over time, Btrfs can allocate all raw disk chunks without leaving unallocated space, triggering an apparent "out of space / inode" failure even with dozens of gigabytes reported free by df.
