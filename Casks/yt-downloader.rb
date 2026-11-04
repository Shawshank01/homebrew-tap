cask "yt-downloader" do
  version "4.5.2"

  on_arm do
    sha256 "4ca34a52996c7d2caf0c636608a42ef2b528cf9180b97ea0b3497e54913ccc45"
    url "https://github.com/Shawshank01/yt-downloader-electron/releases/download/v#{version}/YT-Downloader-mac-arm64-#{version}.dmg"
  end
  on_intel do
    sha256 "cc814a9fa005052bb4cd939f38507f75e53fdf520a5ed3525c2622ab56da7e2a"
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
