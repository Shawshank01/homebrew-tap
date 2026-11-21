cask "vidbutler" do
  version "5.1.0"

  on_arm do
    sha256 "caac0dd3c16d5bc9f012d145a71d0988af6466bed1cb18b6d773b025ab1f78c9"
    url "https://github.com/Shawshank01/VidButler/releases/download/v#{version}/VidButler-mac-arm64-#{version}.dmg"
  end
  on_intel do
    sha256 "102cb1f4bb530ca3c5ea99634cf48a0032457207380563fc715998f4d58f89bc"
    url "https://github.com/Shawshank01/VidButler/releases/download/v#{version}/VidButler-mac-x64-#{version}.dmg"
  end

  name "VidButler"
  desc "Video downloader and media processor using yt-dlp and FFmpeg with AI assistance"
  homepage "https://github.com/Shawshank01/VidButler"

  depends_on :macos

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
    "~/Library/Saved Application State/com.vidbutler.app.savedState",
  ]
end
