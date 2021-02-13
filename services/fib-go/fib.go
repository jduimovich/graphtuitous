package main

import (
	"encoding/json"
	"fmt"
	"net/http"
	"os"
	"time"
)

type Response struct {
	Hostname string `json:"hostname"`
	Version  string `json:"version"`
	Colour   string `json:"colour"`
	Count    int    `json:"count"`
	Stack    string `json:"stack"`
	Loop     int    `json:"loop"`
	Compute  string `json:"compute"`
	Time     int64  `json:"time"`
}
type Health struct {
	Health string `json:"health"`
	Count  int    `json:"count"`
}

var health *Health = &Health{
	Health: "Ok",
	Count:  0,
}

var response *Response = &Response{
	Hostname: "GO",
	Version:  "1.1",
	Colour:   "yellow",
	Count:    0,
	Stack:    "golang",
	Loop:     10000,
	Compute:  "fib(12)",
	Time:     0,
}

func fib(n int) int {
	if n < 3 {
		return 1
	}
	return fib(n-1) + fib(n-2)
}

func healthHandler(w http.ResponseWriter, r *http.Request) {
	health.Count++
	fmt.Printf("healthHandler: called %d times\n", health.Count)
	switch r.Method {
	case "GET":
		j, _ := json.Marshal(health)
		w.Write(j)
	default:
		w.WriteHeader(http.StatusMethodNotAllowed)
		fmt.Fprintf(w, "StatusMethodNotAllowed")
	}
}

func fibHandler(w http.ResponseWriter, r *http.Request) {
	if response.Count%20 == 0 {
		fmt.Printf("fibHandler: called %d times\n", response.Count)
	}
	switch r.Method {
	case "GET":
		response.Hostname, _ = os.Hostname()
		start := time.Now()
		for i := 1; i < response.Loop; i++ {
			fib(12)
		}
		response.Time = time.Since(start).Milliseconds()
		response.Count++
		j, _ := json.Marshal(response)
		w.Write(j)
	default:
		w.WriteHeader(http.StatusMethodNotAllowed)
		fmt.Fprintf(w, "StatusMethodNotAllowed")
	}
}

func main() {
	port := os.Getenv("PORT")
	if port == "" {
		port = "8080"
	}
	fmt.Printf("WebServer running on %s\n", port)
	http.HandleFunc("/fib", fibHandler)
	http.HandleFunc("/health", healthHandler)
	http.ListenAndServe(":"+port, nil)
}
