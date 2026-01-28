FROM docker.io/rust AS chef

WORKDIR /app
ENV CARGO_REGISTRIES_CRATES_IO_PROTOCOL=sparse 
RUN cargo install cargo-chef --locked

# CHEF CACHE
FROM chef AS planner
WORKDIR /app
COPY ./src ./src  
COPY ./Cargo.* ./
RUN cargo chef prepare --recipe-path recipe.json

# BUILD DEPS
FROM chef AS builder 
WORKDIR /app
COPY --from=planner /app/recipe.json recipe.json
# Caching Docker layer for deps
RUN cargo chef cook --release --recipe-path recipe.json
# BUILD APP
COPY ./src ./src  
COPY ./Cargo.* ./
RUN cargo build --release --bin fib-rust

# RUNTIME
FROM debian:13.3-slim  AS runtime 
WORKDIR /app
ENV ROCKET_ADDRESS=0.0.0.0
ENV HTML_DIR=/app/data
COPY --from=builder /app/target/release/fib-rust /usr/local/bin  
CMD [ "/usr/local/bin/fib-rust" ] 