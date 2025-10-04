package commands

import (
	"fmt"

	"github.com/alonsofritz/grimorium-cli/internal/password"
	"github.com/spf13/cobra"
)

var length int
var symbols bool

var passwordCmd = &cobra.Command{
	Use:   "password",
	Short: "Gera uma senha aleatória",
	Run: func(cmd *cobra.Command, args []string) {
		fmt.Println(password.GeneratePassword(length, symbols))
	},
}

func init() {
	passwordCmd.Flags().IntVarP(&length, "length", "l", 12, "Tamanho da senha")
	passwordCmd.Flags().BoolVarP(&symbols, "symbols", "s", false, "Incluir símbolos especiais")
}
