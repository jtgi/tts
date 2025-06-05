#!/bin/bash
# Bash completion for tts
# Source this file or add to ~/.bash_completion.d/

_tts_completions() {
    local cur prev opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    
    # All available options
    opts="-k --api-key -v --voice -m --model -f --format -c --chunk-size -d --debug -h --help"
    
    case "${prev}" in
        -k|--api-key)
            # Don't complete API keys for security
            return 0
            ;;
        -v|--voice)
            # Common ElevenLabs voice IDs
            local voices="21m00Tcm4TlvDq8ikWAM EXAVITQu4vr4xnSDxMaL ErXwobaYiN019PkySvjV MF3mGyEYCl7XYWbV9V6O TxGEqnHWrfWFTfGW9XjX VR6AewLTigWG4xSOukaG pNInz6obpgDQGcFmaJgB g5CIjZEefAph4nQFvHAz CYw3kZ02Hs0563khs1Fj o7lPyFk7O2rNd5JWRqJb"
            COMPREPLY=( $(compgen -W "${voices}" -- ${cur}) )
            return 0
            ;;
        -m|--model)
            # ElevenLabs model IDs
            local models="eleven_monolingual_v1 eleven_multilingual_v1 eleven_multilingual_v2"
            COMPREPLY=( $(compgen -W "${models}" -- ${cur}) )
            return 0
            ;;
        -f|--format)
            # Output formats
            local formats="mp3_44100_128 mp3_44100_192 pcm_16000 pcm_22050 pcm_24000 pcm_44100 ulaw_8000"
            COMPREPLY=( $(compgen -W "${formats}" -- ${cur}) )
            return 0
            ;;
        -c|--chunk-size)
            # Common chunk sizes
            local sizes="1000 2500 5000 10000 20000"
            COMPREPLY=( $(compgen -W "${sizes}" -- ${cur}) )
            return 0
            ;;
        *)
            ;;
    esac
    
    # Complete options
    if [[ ${cur} == -* ]]; then
        COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
        return 0
    fi
    
    # Complete filenames for input redirection
    COMPREPLY=( $(compgen -f -- ${cur}) )
}

complete -F _tts_completions tts