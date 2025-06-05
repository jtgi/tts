class Tts < Formula
  desc "Text-to-speech CLI using ElevenLabs API"
  homepage "https://github.com/YOUR_USERNAME/tts"
  url "https://github.com/YOUR_USERNAME/tts/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "PLACEHOLDER_SHA256"
  license "MIT"

  def install
    bin.install "tts"
  end

  def caveats
    <<~EOS
      To use tts, you need to set your ElevenLabs API key:
        export ELEVENLABS_API_KEY='your-api-key-here'

      Usage:
        echo "Hello world" | tts > hello.mp3
        cat book.txt | tts -v EXAVITQu4vr4xnSDxMaL > book.mp3
    EOS
  end

  test do
    assert_match "Usage:", shell_output("#{bin}/tts --help", 0)
  end
end