package main

import (
	"encoding/json"
	"log"
	"net/http"
)

func health(w http.ResponseWriter, r *http.Request) {
	json.NewEncoder(w).Encode(map[string]string{"status": "ok"})
}

func index(w http.ResponseWriter, r *http.Request) {
	json.NewEncoder(w).Encode(map[string]string{"service": "eval-go-min"})
}

func main() {
	http.HandleFunc("/health", health)
	http.HandleFunc("/", index)
	log.Println("listening on 8000")
	log.Fatal(http.ListenAndServe("0.0.0.0:8000", nil))
}
