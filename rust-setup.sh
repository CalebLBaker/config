#!/bin/sh

rustup toolchain install nightly --allow-downgrade --profile minimal --component clippy
rustup component add rust-src
rustup component add rls
rustup target add wasm32-unknown-unknown
rustup component add rustfmt
cargo install wasm-gc
cargo install wasm-bindgen-cli
cargo install wasm-pack

