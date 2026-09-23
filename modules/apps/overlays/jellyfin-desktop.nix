final: prev: {
  jellyfin-desktop = prev.jellyfin-desktop.overrideAttrs (old: {
    version = "3.0.0";

    src = prev.fetchFromGitHub {
      owner = "jellyfin";
      repo = "jellyfin-desktop";
      rev = "2cb4a4456fd29b5b62d825ef0e5df93ed6913328";
      hash = "sha256-KUP1qmnD8HAVPF8vaORtVYdHEZWdzm7oqhvkDMWJg6o=";
    };
  });
}
