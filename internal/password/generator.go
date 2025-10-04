package password

import (
	"math/rand"
	"time"
)

func GeneratePassword(length int, useSymbols bool) string {
	r := rand.New(rand.NewSource(time.Now().UnixNano()))
	letters := "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
	if useSymbols {
		letters += "!@#$%&*?"
	}

	pass := make([]byte, length)
	for i := range pass {
		pass[i] = letters[r.Intn(len(letters))]
	}
	return string(pass)
}
