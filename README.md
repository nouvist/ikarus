<h1 align="center">
  <img src="./docs/IkarusLogo.svg" height="48" />
</h1>

<p align="center">
  <img src="./docs/Logo.svg" height="96" />
</p>

Ikarus adalah perangkat lunak otomasi browser melalui bahasa pemrograman visual.
Ditujukan untuk berusaha mereduksi kewajiban sintaksis dalam memanipulasi DOM.

Dikembangkan dalam rangka penyelesaian skripsi untuk meraih gelar Sarjana Teknik
Informatika di Institut Sains dan Teknologi Nasional.

## Membangun

Untuk membangun Ikarus, diasumsikan lingkungan yang memuat perangkat pembangun
Flutter dan Rust.

1. Gunakan FRB dengan `cargo install flutter_rust_bridge_codegen --version 2.12.0`.
2. Bangun jembatan FFI dengan `flutter_rust_bridge_codegen generate`.
3. Bangun Flutter dengan `flutter build windows --release`.
