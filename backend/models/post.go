package models

import "time"

type Post struct {
	ID        uint      `gorm:"primaryKey" json:"id"`
	Title     string    `json:"title"`
	Content   string    `gorm:"type:text" json:"content"`
	ImageURL  string    `json:"image_url"`
	UserID    uint      `json:"user_id"`
	User      User      `gorm:"constraint:OnUpdate:CASCADE,OnDelete:SET NULL;" json:"user"`
	CreatedAt time.Time `json:"created_at"`
}