cask "vidbutler" do
  version "5.3.1"

  on_arm do
    sha256 "b29eccabc46688c442ef4b50c637cc63f725a50fe292806e5c51f8265ba31c01"
    url "https://github.com/Shawshank01/VidButler/releases/download/v#{version}/VidButler-mac-arm64-#{version}.dmg"
  end
  on_intel do
    sha256 "edbd46b7867f0eb6f3c534a38f2a93d77972b7e1777df47ba5b96dcd3ea13f7e"
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
