package main

import (
	"net/http"

	"github.com/gin-gonic/gin"
)

var (
  alwaysSameRes = res{ Status: http.StatusOK, Message: "pong" }

  offered = []string{gin.MIMEJSON}
)

type res struct {
  Status int `json:"status"`
  Message string `json:"message"`
}

func main() {
  r := gin.Default()

  r.GET("/ping", func(c *gin.Context) {
    c.Negotiate(http.StatusOK, gin.Negotiate{
      Offered: offered,
      Data: alwaysSameRes,
    })
  })

  r.Run()
}
