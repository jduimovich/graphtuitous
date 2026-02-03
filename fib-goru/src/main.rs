 
use std::sync::Mutex;
use std::time::Instant;
use actix_web::{web, App, HttpResponse, HttpServer, Responder};
use serde::Serialize;
use std::env; 

#[derive(Serialize, Clone)]
struct Response {
    hostname: String,
    version: String,
    colour: String,
    count: usize,
    stack: String,
    loop_count: usize,
    compute: String,
    time: u128,
}

#[derive(Serialize, Clone)]
struct Health {
    health: String,
    count: usize,
}

struct AppState {
    health: Mutex<Health>,
    response: Mutex<Response>,
}

fn fib(n: usize) -> usize {
    if n < 3 {
        1
    } else {
        fib(n - 1) + fib(n - 2)
    }
}

async fn health_handler(data: web::Data<AppState>) -> impl Responder {
    let health_clone = {
        let mut health = data.health.lock().unwrap();
        health.count += 1;
        if health.count % 100 == 0 {
            println!("healthHandler: called {} times", health.count);
        }
        health.clone()
    };
    HttpResponse::Ok().json(health_clone)
}

async fn fib_handler(data: web::Data<AppState>) -> impl Responder {
    let loop_count = data.response.lock().unwrap().loop_count;

    // Perform expensive computation without holding the lock
    let hostname = gethostname::gethostname().to_string_lossy().into_owned();
    let start = Instant::now();
    for _ in 1..loop_count {
        fib(12);
    }
    let time = start.elapsed().as_millis();

    // Lock again to update the shared state and create the response body
    let response_clone = {
        let mut response = data.response.lock().unwrap();
        response.count += 1;
        response.hostname = hostname;
        response.time = time;

        if response.count % 100 == 0 {
            println!("fibHandler: called {} times", response.count);
        }
        response.clone()
    };

    HttpResponse::Ok().json(response_clone)
}

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    let port = env::var("PORT").unwrap_or_else(|_| "8080".to_string());
    println!("WebServer running on {}", port);

    let health = Health {
        health: "Ok".to_string(),
        count: 0,
    };

    let response = Response {
        hostname: "RUST".to_string(),
        version: "1.1".to_string(),
        colour: "purple".to_string(),
        count: 0,
        stack: "rust".to_string(),
        loop_count: 100000,
        compute: "fib(12)".to_string(),
        time: 0,
    };

    let app_state = web::Data::new(AppState {
        health: Mutex::new(health),
        response: Mutex::new(response),
    });

    HttpServer::new(move || {
        App::new()
            .app_data(app_state.clone())
            .route("/fib", web::get().to(fib_handler))
            .route("/health", web::get().to(health_handler))
            .route("/", web::get().to(health_handler))
            .default_service(web::route().to(|| HttpResponse::NotFound()))
    })
    .bind(format!("0.0.0.0:{}", port))?
    .run()
    .await
}