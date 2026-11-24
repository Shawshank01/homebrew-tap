cask "vidbutler" do
  version "5.3.7"

  on_arm do
    sha256 "d31bfbf68a4398c6de821bf53213aa9459867678cb6d5f084f7000e1a4fd2af4"
    url "https://github.com/Shawshank01/VidButler/releases/download/v#{version}/VidButler-mac-arm64-#{version}.dmg"
  end
  on_intel do
    sha256 "5f93ba9a8d67d927cb81f32f4d4e5f47241f54f3e071dc162cd0130f32f2a1fd"
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
