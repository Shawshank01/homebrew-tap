cask "vidbutler" do
  version "5.3.3"

  on_arm do
    sha256 "6a2f8991dd8a5c1293bd490ab1c7703e8118982c2c247e9f4786d39cbe95c09d"
    url "https://github.com/Shawshank01/VidButler/releases/download/v#{version}/VidButler-mac-arm64-#{version}.dmg"
  end
  on_intel do
    sha256 "66c9ccdc8dbf7a8b5922fdc2bcfb1ab5cfdd982a8d1ee051a5fccb53bbf6e29e"
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

  uninstall quit: "com.vidbutler.app"

  # Match either historical casing without trashing aliases twice on a
  # case-insensitive volume. Only target the app-owned entries.
  profile_dir = "~/Library/Application Support/[Vv]id[Bb]utler"
  profile_entries = [
    "user-settings.json", "ai-keys.json", "tool-data",
    "user-settings.json.*.tmp", "ai-keys.json.*.tmp",
    "Cache", "Code Cache", "Crashpad", "DIPS", "DawnGraphiteCache", "DawnWebGPUCache", "Extension State",
    "GPUCache", "GPUPersistentCache", "GraphiteDawnCache", "Local State", "Local Storage", "Network",
    "Network Persistent State", "Preferences", "Session Storage", "Shared Dictionary", "Trust Tokens",
    "Trust Tokens-journal", "blob_storage", "declarative_performance_observer.db",
    "declarative_performance_observer.db-journal",
  ]
  zap trash: profile_entries.map { |entry| "#{profile_dir}/#{entry}" } + [
    "~/Library/Preferences/com.vidbutler.app.plist",
    "~/Library/Saved Application State/com.vidbutler.app.savedState",
  ], rmdir: profile_dir
end
