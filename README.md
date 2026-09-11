<h1 align="center">
  <img src="./docs/IkarusLogo.svg" height="48" />
</h1>

<p align="center">
  <img src="./docs/Logo.svg" height="96" />
</p>

[![Unduh untuk Windows](https://img.shields.io/badge/Unduh%20untuk-Windows-green)](https://github.com/nouvist/ikarus/releases/download/v0.1.1/ikarus-windows-x64.tar.gz)
[![Unduh untuk Linux](https://img.shields.io/badge/Unduh%20untuk-Linux-green)](https://github.com/nouvist/ikarus/releases/download/v0.1.1/ikarus-linux-x64.tar.gz)

Ikarus adalah perangkat lunak otomasi browser melalui bahasa pemrograman visual.
Ditujukan untuk berusaha mereduksi kewajiban sintaksis dalam memanipulasi DOM.

Dikembangkan dalam rangka penyelesaian skripsi untuk meraih gelar Sarjana Teknik
Informatika di Institut Sains dan Teknologi Nasional.

## Lingkungan Disarankan

Untuk menggunakan Ikarus, harap gunakan:

1. **Google Chrome** karena otomasi berbasis CDP (melalui Chromiumoxide).
2. **DeepSeek V4 Flash 0731** disarankan karena memiliki dukungan skema JSON teruji.

## Membangun

Untuk membangun Ikarus, diasumsikan lingkungan yang memuat perangkat pembangun
Flutter dan Rust.

1. Gunakan FRB dengan `cargo install flutter_rust_bridge_codegen --version 2.12.0`.
2. Bangun jembatan FFI dengan `flutter_rust_bridge_codegen generate`.
3. Bangun Flutter dengan `flutter build windows --release`.

## YouTube

<p align="center">
  <a href="https://www.youtube.com/watch?v=ZfQu2x5ryV0">
    <img src="./docs/YouTube.png" />
  </a>
</p>

## Lisensi

Kode sumber didistribusikan di bawah lisensi Mozilla Public License 2.0
(MPL-2.0), yang mengizinkan penggunaan, modifikasi, dan distribusi ulang kode
dengan ketentuan bahwa perubahan pada berkas yang berlisensi MPL-2.0 tetap
harus dipublikasikan di bawah lisensi yang sama.
