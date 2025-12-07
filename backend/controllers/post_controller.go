package controllers

import (
	"backend/config"
	"backend/models"
	"fmt"
	"path/filepath"
	"strconv"
	"time"

	"github.com/gin-gonic/gin"
)

func GetPosts(c *gin.Context) {
	var posts []models.Post
	// Preload("User") artinya ambil juga data si pembuat post
	config.DB.Preload("User").Order("created_at desc").Find(&posts)
	c.JSON(200, posts)
}

func CreatePosts(c *gin.Context) {
	title := c.PostForm("title")
	content := c.PostForm("content")
	userID, _ := strconv.Atoi(c.PostForm("user_id")) // User ID dari form

	file, err := c.FormFile("image")
	if err != nil {
		c.JSON(400, gin.H{"error": "Wajib upload gambar"})
		return
	}

	filename := fmt.Sprintf("post_%d%s", time.Now().Unix(), filepath.Ext(file.Filename))
	c.SaveUploadedFile(file, "uploads/"+filename)
	
	// Ganti localhost:8080 sesuai IP komputer jika dites di HP (misal 192.168.1.X:8080)
	imageURL := fmt.Sprintf("http://10.0.2.2:5000/uploads/%s", filename)

	post := models.Post{Title: title, Content: content, ImageURL: imageURL, UserID: uint(userID)}
	config.DB.Create(&post)

	c.JSON(200, gin.H{"message": "Sukses!", "data": post})
}