cask "vidbutler" do
  version "5.0.1"

  on_arm do
    sha256 "5e89a8464fa9e527639b35177b17b4d45a60655479a45109dc23e708ed69ca88"
    url "https://github.com/Shawshank01/Vidbutler/releases/download/v#{version}/VidButler-mac-arm64-#{version}.dmg"
  end
  on_intel do
    sha256 "30a86a1cd2eafaec28f8d2b64f834d305a87e3dd06623d4282fa4cdd852088fd"
    url "https://github.com/Shawshank01/Vidbutler/releases/download/v#{version}/VidButler-mac-x64-#{version}.dmg"
  end

  name "VidButler"
  desc "Video downloader and media processor using yt-dlp and FFmpeg with AI assistance"
  homepage "https://github.com/Shawshank01/Vidbutler"

  app "VidButler.app"

  # VidButler is not notarized. Tap installations remove the downloaded quarantine
  # attribute so users do not need to run xattr manually.
  postflight_steps do
    run "/usr/bin/xattr",
args: ["-dr", "com.apple.quarantine", "{{appdir}}/VidButler.app"]
  end

  zap trash: [
    "~/Library/Application Support/VidButler",
    "~/Library/Preferences/com.vidbutler.app.plist",
  ]
end
