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

### Basic Options
- `-k, --api-key` - ElevenLabs API key
- `-v, --voice` - Voice ID (default: Rachel)
- `-m, --model` - Model ID (default: eleven_monolingual_v1)
- `-f, --format` - Output format (default: mp3_44100_128)
- `-c, --chunk-size` - Characters per chunk (default: 5000)
- `-d, --debug` - Enable debug output
- `-p, --play` - Play audio directly (macOS only)
- `-l, --latency` - Optimize streaming latency 0-4 (default: 1)

### Voice Control Options
- `--stability` - Voice stability 0.0-1.0 (default: 0.5)
- `--similarity-boost` - Voice similarity boost 0.0-1.0 (default: 0.75)
- `--style` - Speaking style intensity 0.0-1.0 (default: 0.0)
- `--speaker-boost` - Enable speaker boost true/false (default: true)

### Advanced Options
- `--seed` - Seed for reproducible generation
- `--previous-text` - Previous text context for better pronunciation
- `--next-text` - Next text context for better pronunciation
- `--previous-request-ids` - Comma-separated previous request IDs
- `--next-request-ids` - Comma-separated next request IDs

### Help
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

# Fine-tune voice characteristics
echo "Hello" | tts --stability 0.8 --similarity-boost 0.9 > stable.mp3

# Enable expressive speaking
echo "Wow!" | tts --style 1.0 --speaker-boost true > expressive.mp3

# Reproducible generation
echo "Hello" | tts --seed 12345 > hello1.mp3
echo "Hello" | tts --seed 12345 > hello2.mp3  # Identical

# Context-aware pronunciation
echo "Dr. Smith" | tts --previous-text "The doctor will see you now." > context.mp3
```

## Environment Variables

All options can be set via environment variables:

```sh
export ELEVENLABS_API_KEY="your-api-key"
export TTS_VOICE_ID="21m00Tcm4TlvDq8ikWAM"
export TTS_MODEL_ID="eleven_monolingual_v1"
export TTS_OUTPUT_FORMAT="mp3_44100_128"
export TTS_CHUNK_SIZE="5000"
export TTS_OPTIMIZE_STREAMING_LATENCY="1"
export TTS_STABILITY="0.5"
export TTS_SIMILARITY_BOOST="0.75"
export TTS_STYLE="0.0"
export TTS_USE_SPEAKER_BOOST="true"
export TTS_SEED=""
export TTS_PREVIOUS_TEXT=""
export TTS_NEXT_TEXT=""
export TTS_PREVIOUS_REQUEST_IDS=""
export TTS_NEXT_REQUEST_IDS=""
```

## Shell Completion

Shell completions are automatically installed with the standard installation methods. If you need to install them manually:

```sh
# Install all (includes completions)
make install

# Or install completions separately
make install-bash-completion
make install-zsh-completion
```

## Requirements

- POSIX shell
- curl

## License

MIT
