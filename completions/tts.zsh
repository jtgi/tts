#compdef tts
# Zsh completion for tts
# Add to ~/.zsh/completions/ or source directly

_tts() {
    local -a opts
    local -a voices
    local -a models
    local -a formats
    local -a chunks
    
    opts=(
        '-k[ElevenLabs API key]:api key:'
        '--api-key[ElevenLabs API key]:api key:'
        '-v[Voice ID]:voice id:->voices'
        '--voice[Voice ID]:voice id:->voices'
        '-m[Model ID]:model id:->models'
        '--model[Model ID]:model id:->models'
        '-f[Output format]:format:->formats'
        '--format[Output format]:format:->formats'
        '-c[Characters per chunk]:chunk size:->chunks'
        '--chunk-size[Characters per chunk]:chunk size:->chunks'
        '-d[Enable debug output]'
        '--debug[Enable debug output]'
        '-h[Show help message]'
        '--help[Show help message]'
    )
    
    voices=(
        '21m00Tcm4TlvDq8ikWAM:Rachel (default)'
        'EXAVITQu4vr4xnSDxMaL:Bella'
        'ErXwobaYiN019PkySvjV:Antoni'
        'MF3mGyEYCl7XYWbV9V6O:Elli'
        'TxGEqnHWrfWFTfGW9XjX:Josh'
        'VR6AewLTigWG4xSOukaG:Arnold'
        'pNInz6obpgDQGcFmaJgB:Adam'
        'g5CIjZEefAph4nQFvHAz:Callum'
        'CYw3kZ02Hs0563khs1Fj:Charlie'
        'o7lPyFk7O2rNd5JWRqJb:Charlotte'
    )
    
    models=(
        'eleven_monolingual_v1:English v1 (default)'
        'eleven_multilingual_v1:Multilingual v1'
        'eleven_multilingual_v2:Multilingual v2'
    )
    
    formats=(
        'mp3_44100_128:MP3 128kbps (default)'
        'mp3_44100_192:MP3 192kbps'
        'pcm_16000:PCM 16kHz'
        'pcm_22050:PCM 22kHz'
        'pcm_24000:PCM 24kHz'
        'pcm_44100:PCM 44.1kHz'
        'ulaw_8000:μ-law 8kHz'
    )
    
    chunks=(
        '1000:Small chunks'
        '2500:Medium chunks'
        '5000:Default chunks'
        '10000:Large chunks'
        '20000:Extra large chunks'
    )
    
    _arguments -s -S $opts
    
    case "$state" in
        voices)
            _describe 'voice' voices
            ;;
        models)
            _describe 'model' models
            ;;
        formats)
            _describe 'format' formats
            ;;
        chunks)
            _describe 'chunk size' chunks
            ;;
    esac
    
    # File completion for input
    _files
}

_tts "$@"