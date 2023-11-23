package main

import (
	"net/http"
	"github.com/Kagami/go-avif"
	"image"
	_ "image/jpeg"
	_ "image/png"
	"log"

)

func uploadFileHandler(w http.ResponseWriter, r *http.Request) {

	// Parse the request body
	err := r.ParseMultipartForm(10 << 20) // 10 MB limit
	if err != nil {
		http.Error(w, "Unable to parse form", http.StatusBadRequest)
		return
	}

	// Get the file from the request
	file, _, err := r.FormFile("file")
	if err != nil {
		http.Error(w, "Unable to get file from form", http.StatusBadRequest)
		return
	}
	defer file.Close()

	img, _, err := image.Decode(file)
	if err != nil {
		log.Fatalf("Can't decode source file: %v", err)
	}

	err = avif.Encode(w, img, nil)
	if err != nil {
		log.Fatalf("Can't encode source image: %v", err)
	}
}

func main() {
	http.HandleFunc("/upload", uploadFileHandler)
	http.ListenAndServe(":8100", nil)
}