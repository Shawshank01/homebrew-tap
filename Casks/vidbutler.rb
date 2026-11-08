cask "vidbutler" do
  version "4.6.0"

  on_arm do
    sha256 "f5c2a2348795264c7afa7b9e6757cf0d0b6e8cfefb143e9fc46dbb9e7502f6d0"
    url "https://github.com/Shawshank01/Vidbutler/releases/download/v#{version}/VidButler-mac-arm64-#{version}.dmg"
  end
  on_intel do
    sha256 "d7321ff613001e9562735555385cbbe8e16c8598416f8a157da08195c70598e6"
    url "https://github.com/Shawshank01/Vidbutler/releases/download/v#{version}/VidButler-mac-x64-#{version}.dmg"
  end

  name "VidButler"
  desc "Video downloader and media processor using yt-dlp and FFmpeg with AI assistance"
  homepage "https://github.com/Shawshank01/Vidbutler"

  app "VidButler.app"

  # Automatically strips quarantine upon installation
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/VidButler.app"]
  end

  zap trash: [
    "~/Library/Application Support/VidButler",
    "~/Library/Preferences/com.vidbutler.app.plist",
    # Legacy cleanups for migrating users:
    "~/Library/Application Support/yt-downloader-electron",
    "~/Library/Preferences/com.ytdownloader.app.plist",
  ]
end
