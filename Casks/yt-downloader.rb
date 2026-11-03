cask "yt-downloader" do
  version "4.4.0"

  on_arm do
    sha256 "9c78da9154ccaf59493d6bdf1409ffd53eb6020d009eecc0d484cf46189ad339"
    url "https://github.com/Shawshank01/yt-downloader-electron/releases/download/v#{version}/YT-Downloader-mac-arm64-#{version}.dmg"
  end
  on_intel do
    sha256 "5da88c857330491ae75ae970a06eacacf8b9b6ab832a95c8e67674eaac5f7d72"
    url "https://github.com/Shawshank01/yt-downloader-electron/releases/download/v#{version}/YT-Downloader-mac-x64-#{version}.dmg"
  end

  name "YT Downloader"
  desc "Video downloader using yt-dlp and FFmpeg with AI assistance"
  homepage "https://github.com/Shawshank01/yt-downloader-electron"

  app "YT Downloader.app"

  # Automatically strips quarantine upon installation
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/YT Downloader.app"],
                   sudo: false
  end

  zap trash: [
    "~/Library/Application Support/yt-downloader-electron",
    "~/Library/Preferences/com.ytdownloader.app.plist",
  ]
end
