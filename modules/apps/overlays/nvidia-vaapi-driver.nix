final: prev: {
  nvidia-vaapi-driver = prev.nvidia-vaapi-driver.overrideAttrs (old: {
    src = prev.fetchFromGitHub {
      owner = "elFarto";
      repo = "nvidia-vaapi-driver";
      rev = "03bb5a0c082493f95f2cd54ffd31dbfa8c7cbe7d";
      hash = "sha256-mI0QpIRm1itUPq8y4UHn45cDZhLtkj2O9XGIROJ4TIE=";
    };
  });
}
