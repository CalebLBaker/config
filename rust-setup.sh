#!/bin/sh

rustup toolchain install nightly --allow-downgrade --profile minimal --component clippy
rustup component add rust-src
rustup component add rls

