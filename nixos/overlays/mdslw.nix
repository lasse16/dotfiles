{
  lib,
  rustPlatform,
  fetchFromGitHub,
  fetchurl,
  nix-update-script,
}: let
  # build.rs downloads CLDR suppressions at compile time; pre-fetch them instead
  cldrUrl = lang: "https://raw.githubusercontent.com/unicode-org/cldr-json/main/cldr-json/cldr-segments-full/segments/${lang}/suppressions.json";
  cldrHashes = {
    de = "sha256-UWftkf5EoXMUNqJQStQQMeTBHPkJEb475VEdHY65RpY=";
    en = "sha256-L/kf4d4lmEiYWPcsgVZwbO3o8Xg5qgqrgHA0G7R9xbg=";
    es = "sha256-4nJ/M/PV1JaP2yQdUUgngEcti6k4LbQwJzldO5noO4Y=";
    fr = "sha256-+8IRov9qlmNsaWEdJpYqPMzHZi89rlYc2eNb1eq7QhM=";
    it = "sha256-p+ULlpB00qLEhIv2ccSXK48cu9LvfvVRv0vzUzsJg8Y=";
  };
  cldrFiles = lib.mapAttrs (lang: hash: fetchurl {url = cldrUrl lang; inherit hash;}) cldrHashes;
in
rustPlatform.buildRustPackage (finalAttrs: {
  pname = "mdslw";
  version = "0.17.2";
  __structuredAttrs = true;

  src = fetchFromGitHub {
    owner = "razziel89";
    repo = "mdslw";
    tag = finalAttrs.version;
    hash = "sha256-4iSQS13tMglOV8nWBw7Zxi8+DcKHKGl99cuHKvOIE7s=";
  };

  cargoHash = "sha256-emaBv9b9WjFKbyN5V0A5N8NHea8YMBvj256gv9P116E=";

  # build.rs downloads CLDR suppressions per language over HTTP; read the
  # pre-fetched files from disk instead (the Nix sandbox blocks networking)
  patches = [ ./mdslw-offline-langs.patch ];

  env = lib.mapAttrs' (lang: file:
    lib.nameValuePair "MDSLW_LANG_${lib.toUpper lang}" (toString file)
  ) cldrFiles;

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "Prepare your markdown for easy diff'ing";
    homepage = "https://github.com/razziel89/mdslw";
    changelog = "https://github.com/razziel89/mdslw/releases/tag/${finalAttrs.src.tag}";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [ ];
    mainProgram = "mdslw";
  };
})
