package commands

import (
	"fmt"

	"github.com/alonsofritz/grimorium-cli/internal/translator"
	"github.com/spf13/cobra"
)

var fromLang, toLang string

var translateCmd = &cobra.Command{
	Use:   "translate [palavra]",
	Short: "Traduz uma palavra de um idioma para outro",
	Args:  cobra.ExactArgs(1),
	Run: func(cmd *cobra.Command, args []string) {
		word := args[0]
		result := translator.TranslateWord(word, fromLang, toLang)
		fmt.Println(result)
	},
}

func init() {
	translateCmd.Flags().StringVarP(&fromLang, "from", "f", "en", "Idioma de origem (ex: en)")
	translateCmd.Flags().StringVarP(&toLang, "to", "t", "pt", "Idioma de destino (ex: pt)")
}
