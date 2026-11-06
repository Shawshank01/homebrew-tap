cask "yt-downloader" do
  version "4.6.0"

  on_arm do
    sha256 "f5c2a2348795264c7afa7b9e6757cf0d0b6e8cfefb143e9fc46dbb9e7502f6d0"
    url "https://github.com/Shawshank01/yt-downloader-electron/releases/download/v#{version}/YT-Downloader-mac-arm64-#{version}.dmg"
  end
  on_intel do
    sha256 "d7321ff613001e9562735555385cbbe8e16c8598416f8a157da08195c70598e6"
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
