final: prev: {
  librepods = prev.librepods.overrideAttrs (old: {
    src = prev.fetchFromGitHub {
      owner = "librepods-org";
      repo = "librepods";
      tag = "v1.0.1-rc1";
      hash = "sha256-9RsDr78jjHAAU1rrnbxFPQw2EN6zQTvVKfn+ulZRmSE=";
    };
  });
}
