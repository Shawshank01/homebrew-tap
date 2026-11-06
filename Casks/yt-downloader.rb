cask "yt-downloader" do
  version "4.5.3"

  on_arm do
    sha256 "384f4c2617ce8f323bc724dd861ed7379cf556cd20b4ebcade46a7cb9a46d665"
    url "https://github.com/Shawshank01/yt-downloader-electron/releases/download/v#{version}/YT-Downloader-mac-arm64-#{version}.dmg"
  end
  on_intel do
    sha256 "d12018e89bd73cc4498a32d501a4d9aeb6e1c3e437200844a2c75b0bce5ff75d"
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
