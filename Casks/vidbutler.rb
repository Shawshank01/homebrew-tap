cask "vidbutler" do
  version "5.0.0"

  on_arm do
    sha256 "3ff9387753bab58f7707dd09c214512a4ca5b68c204811a89e8ab75c18ed9c76"
    url "https://github.com/Shawshank01/Vidbutler/releases/download/v#{version}/VidButler-mac-arm64-#{version}.dmg"
  end
  on_intel do
    sha256 "0bb5cf94bcb48159617e3bb35b9fc39dc13b4d5ed6b735aba63076301e538222"
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
