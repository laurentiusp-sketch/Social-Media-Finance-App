package models

import "time"

type User struct {
	ID        uint      `gorm:"primaryKey" json:"id"`
	FullName  string    `json:"full_name"`
	Email     string    `gorm:"unique" json:"email"`
	Password  string    `json:"-"`
	AvatarURL string    `json:"avatar_url"`
	Posts     []Post    `json:"posts,omitempty"`
	CreatedAt time.Time `json:"created_at"`
}