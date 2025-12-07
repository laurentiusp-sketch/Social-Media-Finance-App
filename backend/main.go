package main

import (
	"backend/config"
	"backend/controllers"
	"backend/models"
	"os"

	"github.com/gin-gonic/gin"
)

func main() {
	config.ConnectDatabase()
	config.DB.AutoMigrate(&models.User{}, &models.Post{})

	if _, err := os.Stat("uploads"); os.IsNotExist(err) {
		os.Mkdir("uploads", 0755)
	}

	r := gin.Default()
	r.Static("/uploads", "./uploads") // Agar gambar bisa dibuka di browser

	r.POST("/api/register", controllers.Register)
	r.GET("/api/posts", controllers.GetPosts)
	r.POST("/api/upload_post", controllers.CreatePosts)

	r.Run(":5000") // Jalan di port 8080
}