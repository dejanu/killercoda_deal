package main

import (
	"fmt"
	"io"
	"net/http"
)

func getRoot(w http.ResponseWriter, r *http.Request) {
	fmt.Printf("got /hello request\n")
	io.WriteString(w, "Hello world!\n")
}

//curl http://127.0.0.1:3333/hello
func main() {
	http.HandleFunc("/hello", getRoot)
	http.ListenAndServe(":3333", nil)
}
