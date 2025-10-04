package commands

import (
	"fmt"
	"os"

	"github.com/spf13/cobra"
)

var rootCmd = &cobra.Command{
	Use:   "cast",
	Short: "cast — spells & tools",
	Long:  "cast — a modular CLI of spells & tools",
}

func Execute() {
	if err := rootCmd.Execute(); err != nil {
		fmt.Println(err)
		os.Exit(1)
	}
}

func init() {
	rootCmd.AddCommand(translateCmd)
	rootCmd.AddCommand(passwordCmd)
}
