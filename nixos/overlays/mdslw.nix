{
  lib,
  rustPlatform,
  fetchFromGitHub,
  nix-update-script,
}:

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
