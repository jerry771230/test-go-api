package main

import (
	"encoding/json"
	"fmt"
	"log"
	"net/http"
	"time"

	"github.com/gorilla/mux"
	"go.uber.org/zap"
)

var sugar *zap.SugaredLogger

func main() {
	// Initialize zap
	logger, _ := zap.NewProduction()
	defer logger.Sync()
	sugar = logger.Sugar()

	r := mux.NewRouter()

	r.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		fmt.Fprint(w, "Hello Go")
		sugar.Info("Hello Go")
	})
	r.HandleFunc("/post_json", postJson).Methods("POST")
	srv := &http.Server{
		Handler: r,
		Addr:    ":8089",
		// Good practice: enforce timeouts for servers you create!
		WriteTimeout: 15 * time.Second,
		ReadTimeout:  15 * time.Second,
	}

	log.Println("Listening on localhost:8089")

	sugar.Fatal(srv.ListenAndServe())
}

func postJson(w http.ResponseWriter, r *http.Request) {
	var p interface{}
	err := json.NewDecoder(r.Body).Decode(&p)
	if err != nil {
		sugar.Fatal(w, err.Error(), http.StatusBadRequest)
		return
	}
	bytes, _ := json.Marshal(p)
	sugar.Info(string(bytes))
}
