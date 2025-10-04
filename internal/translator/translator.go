package translator

import "fmt"

func TranslateWord(word, from, to string) string {
	return fmt.Sprintf("'%s' traduzido de %s para %s", word, from, to)
}
