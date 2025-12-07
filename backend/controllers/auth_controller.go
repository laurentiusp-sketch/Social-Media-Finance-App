package controllers

import (
	"backend/config"
	"backend/models"

	"github.com/gin-gonic/gin"
	"golang.org/x/crypto/bcrypt"
)

func Register(c *gin.Context) {
	var input struct {
		FullName string `json:"full_name"`
		Email    string `json:"email"`
		Password string `json:"password"`
	}
	if err := c.ShouldBindJSON(&input); err != nil {
		c.JSON(400, gin.H{"error": err.Error()})
		return
	}

	hashedPassword, _ := bcrypt.GenerateFromPassword([]byte(input.Password), bcrypt.DefaultCost)
	user := models.User{
		FullName: input.FullName, Email: input.Email, Password: string(hashedPassword),
		AvatarURL: "https://ui-avatars.com/api/?name=" + input.FullName,
	}

	if err := config.DB.Create(&user).Error; err != nil {
		c.JSON(400, gin.H{"error": "Email sudah ada!"})
		return
	}
	c.JSON(200, gin.H{"message": "Register sukses!", "data": user})
}