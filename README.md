# Grimorium CLI

Uma CLI modular de feitiços e ferramentas úteis para desenvolvedores.

## Sobre

Grimorium CLI é uma aplicação de linha de comando desenvolvida em Go que oferece uma coleção de ferramentas úteis para o dia a dia. Atualmente inclui funcionalidades para:

- **Geração de senhas seguras** - Crie senhas aleatórias com configurações personalizáveis
- **Tradutor de palavras** - Traduza palavras entre diferentes idiomas (funcionalidade placeholder)

## Instalação

### Pré-requisitos

- Go 1.25.1 ou superior

### Opção 1: Instalação via Go

```bash
go install github.com/alonsofritz/grimorium-cli/cmd/cli@latest
```

### Opção 2: Compilação a partir do código fonte

```bash
# Clone o repositório
git clone https://github.com/alonsofritz/grimorium-cli.git
cd grimorium-cli

# Compile e instale
make install
```

### Opção 3: Download de binário pré-compilado

```bash
# Compile para sua plataforma
make build

# O binário estará disponível em ./bin/cast
```

## Uso

### Comando Principal

```bash
cast --help
```

### Geração de Senhas

Gere senhas seguras e aleatórias:

```bash
# Senha padrão (12 caracteres)
cast password

# Senha com tamanho personalizado
cast password --length 20

# Senha com símbolos especiais
cast password --symbols

# Combinando opções
cast password --length 16 --symbols
```

**Opções disponíveis:**
- `-l, --length`: Tamanho da senha (padrão: 12)
- `-s, --symbols`: Incluir símbolos especiais (!@#$%&*?)

### Tradutor

Traduza palavras entre diferentes idiomas:

```bash
# Tradução padrão (inglês para português)
cast translate hello

# Especificando idiomas
cast translate hello --from en --to pt

# Usando flags curtas
cast translate bonjour -f fr -t en
```

**Opções disponíveis:**
- `-f, --from`: Idioma de origem (padrão: en)
- `-t, --to`: Idioma de destino (padrão: pt)

## Desenvolvimento

### Configuração do ambiente

```bash
# Clone o repositório
git clone https://github.com/alonsofritz/grimorium-cli.git
cd grimorium-cli

# Configure o ambiente de desenvolvimento
make dev-setup
```

### Comandos do Makefile

```bash
# Ver todos os comandos disponíveis
make help

# Compilar o projeto
make build

# Executar testes
make test

# Executar com argumentos
make run-args ARGS="password --length 20"

# Verificação completa (formato, lint, testes)
make check

# Limpar arquivos de build
make clean
```

### Executando o projeto

```bash
# Executar diretamente
go run cmd/cli/main.go

# Ou usando o Makefile
make run

# Com argumentos
make run-args ARGS="password --help"
```

### Executando testes

```bash
# Testes simples
make test

# Testes com cobertura
make test-coverage
```

## Exemplos de Uso

### Geração de Senhas

```bash
# Senha básica
$ cast password
aB3kL9mN2pQ8

# Senha longa com símbolos
$ cast password -l 20 -s
aB3kL9mN2p@Q8#xY$zK!

# Múltiplas senhas (usando loop bash)
$ for i in {1..3}; do cast password -l 15 -s; done
aB3kL9mN2p@Q8#x
xY$zK!mN2p@Q8aB
Q8#xY$zK!mN2p@a
```

### Tradução

```bash
# Tradução básica
$ cast translate hello
'hello' traduzido de en para pt

# Diferentes idiomas
$ cast translate bonjour -f fr -t es
'bonjour' traduzido de fr para es
```
