# tts

Text-to-speech CLI using ElevenLabs API. Converts text from stdin to audio on stdout.

## Installation

### Quick install

```sh
curl -fsSL https://raw.githubusercontent.com/jtgi/tts/main/install.sh | sh
```

### From source

```sh
make install
```

## Usage

```sh
echo "Hello world" | tts > hello.mp3
cat book.txt | tts -c 10000 > book.mp3
tts < story.txt | mpv -

# Play audio directly (macOS)
echo "Hello world" | tts --play
```

## Configuration

Set your API key:

```sh
export ELEVENLABS_API_KEY="your-api-key"
```

Or pass it directly:

```sh
echo "Hello" | tts -k "your-api-key" > hello.mp3
```

## Options

- `-k, --api-key` - ElevenLabs API key
- `-v, --voice` - Voice ID (default: Rachel)
- `-m, --model` - Model ID (default: eleven_monolingual_v1)
- `-f, --format` - Output format (default: mp3_44100_128)
- `-c, --chunk-size` - Characters per chunk (default: 5000)
- `-d, --debug` - Enable debug output
- `-p, --play` - Play audio directly (macOS only)
- `-h, --help` - Show help

## Examples

```sh
# Debug API issues
echo "test" | tts -d 2>debug.log

# Process large files
cat book.txt | tts -c 10000 > book.mp3

# Extract chapters
grep "^Chapter" book.txt | tts > chapters.mp3

# Different voice
echo "Hello" | tts -v EXAVITQu4vr4xnSDxMaL > hello.mp3

# Play directly on macOS
echo "Hello world" | tts --play
```

## Shell Completion

```sh
# Bash
make install-bash-completion

# Zsh
make install-zsh-completion
```

## Requirements

- POSIX shell
- curl

## License

MIT
