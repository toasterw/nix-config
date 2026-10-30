final: prev: {
  nvidia-vaapi-driver = prev.nvidia-vaapi-driver.overrideAttrs (old: {
    src = prev.fetchFromGitHub {
      owner = "elFarto";
      repo = "nvidia-vaapi-driver";
      rev = "443050726fdb30888a2ced1cea1c5d036ea3b15c";
      hash = "sha256-E2c4Hn4A0Vx3lcmP/Ms7FHEtxsDcxhCmcVFvct1Uv+0=";
    };
  });
}
