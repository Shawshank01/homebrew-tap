cask "yt-downloader" do
  version "4.5.0"

  on_arm do
    sha256 "8930df233b00e9c248f1f8d1d86ba409ec3299ca81e7a8f9aba4363e512aeb10"
    url "https://github.com/Shawshank01/yt-downloader-electron/releases/download/v#{version}/YT-Downloader-mac-arm64-#{version}.dmg"
  end
  on_intel do
    sha256 "33acb2fd3abd1ec90dcddbeb260d394484533344566ba112af056d470d201ed8"
    url "https://github.com/Shawshank01/yt-downloader-electron/releases/download/v#{version}/YT-Downloader-mac-x64-#{version}.dmg"
  end

  name "YT Downloader"
  desc "Video downloader using yt-dlp and FFmpeg with AI assistance"
  homepage "https://github.com/Shawshank01/yt-downloader-electron"

  app "YT Downloader.app"

  # Automatically strips quarantine upon installation
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/YT Downloader.app"]
  end

  zap trash: [
    "~/Library/Application Support/yt-downloader-electron",
    "~/Library/Preferences/com.ytdownloader.app.plist",
  ]
end
