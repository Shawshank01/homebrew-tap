cask "vidbutler" do
  version "5.1.1"

  on_arm do
    sha256 "4d4e6363e6f6c065791609a1e0cef87b04979c2e8c166c9354fa8e35ceee113d"
    url "https://github.com/Shawshank01/VidButler/releases/download/v#{version}/VidButler-mac-arm64-#{version}.dmg"
  end
  on_intel do
    sha256 "545718fd365a86ff7dab0e9aac8e207aa31d16dd33a9de13bc2b525182944ac9"
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
