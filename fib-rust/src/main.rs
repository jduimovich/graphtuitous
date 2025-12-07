   
use rocket::{get, serde::json::Json};
use serde::Serialize;
use std::{sync::atomic::{AtomicU32, Ordering}, time::SystemTime};

static COUNT_SEQ: AtomicU32 = AtomicU32::new(0);

fn get_count() -> u32 {
    COUNT_SEQ.fetch_add(1, Ordering::SeqCst); 
    COUNT_SEQ.load(Ordering::SeqCst) as u32
}
 
  
 fn fib(n: i32) -> i32 {
	if n < 3 {
		1 
    } else { 
        fib(n-1) + fib(n-2)
    }
}

#[derive(Serialize)]
struct Response {
	hostname: String,
	version:  String,
	colour:   String,
	count:    u32,
	stack:     String,
	Loop:     i32,
	compute:  String,
	time:     u128,
}


 fn clockms() -> u128 {
    let now = SystemTime::now();
    let duration_since_epoch = now
        .duration_since(std::time::UNIX_EPOCH)
        .expect("Time went backwards"); // Handle potential errors if system time is set incorrectly
    duration_since_epoch.as_millis()
 }


#[get("/fib")]
fn fib_bench() -> Json<Response> { 
    let c: u32 = get_count(); 

    let start: u128 = clockms();
    for _n in 1..1000 { fib(12);};
    let end: u128 = clockms();
    let t=end - start;

    let r: Response =  Response {
        hostname: gethostname::gethostname().to_string_lossy().into_owned(),
        version:  "1.1".to_string(),
        colour:   "purple".to_string(),
        count:    c,
        stack:    "rust".to_string(),
        Loop:     1000,
        compute:  "fib(12)".to_string(),
        time:     t
    };
    Json(r)
}

#[derive(Serialize)]
struct Health {
    Health: String,
    count: u32,
}

#[get("/")]
fn sendOk() -> Json<Health> {
    let c: u32 = get_count(); 
   let r: Health =  Health {
        Health: "OK".to_string(),
        count: c
    };
    Json(r)
}
 
#[rocket::main]
    async fn main() {
        rocket::build()
            .mount("/", rocket::routes![sendOk])
            .mount("/", rocket::routes![fib_bench])
            .launch()
            .await
            .expect("Rocket failed to launch");
    }
