package main

import (
	"encoding/json"
	"fmt"
	"net/http"
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

var response *Response = &Response{
	Hostname: "GO",
	Version:  "1.1",
	Colour:   "yellow",
	Count:    0,
	Stack:    "golang",
	Loop:     100000,
	Compute:  "fib(12)",
	Time:     0,
}

func fib(n int) int {
	if n < 3 {
		return 1
	}
	return fib(n-1) + fib(n-2)
}

func fibHandler(w http.ResponseWriter, r *http.Request) {
	fmt.Printf("fibHandler\n")
	switch r.Method {
	case "GET":
		fmt.Printf("GET\n")
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
	fmt.Printf("WebServer running on 8083\n")
	http.HandleFunc("/fib", fibHandler)
	http.ListenAndServe(":8083", nil)
}
