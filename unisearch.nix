{
  lib,

  buildPythonApplication,
  uv-build,

  installShellFiles,

  symlinkJoin,

  unicode-character-database,
  unihan-database,
  withUnihan ? false,
}:
let
  unicode-data =
    if withUnihan then
      symlinkJoin {
        name = "unicode-character-database-with-unihan";
        paths = [
          unicode-character-database
          unihan-database
        ];
      }
    else
      unicode-character-database;
  manifest = lib.fromTOML (lib.readFile ./pyproject.toml);
in
buildPythonApplication {
  pname = manifest.project.name;
  version = manifest.project.version;

  pyproject = true;

  src = ./.;

  build-system = [
    uv-build
  ];

  pythonImportsCheck = [
    "unisearch"
  ];

  makeWrapperArgs = [
    "--set"
    "UNICODE_DATA_DIR"
    "${unicode-data}/share/unicode/"
  ];

  passthru = {
    inherit unicode-data;
  };

  nativeBuildInputs = [
    installShellFiles
  ];
  postInstall = ''
    installManPage ./doc/man/*
  '';

  meta = {
    description = "CLI tool to display Unicode character properties";
    homepage = "https://github.com/SandaruKasa/unisearch";
    changelog = "https://github.com/SandaruKasa/unisearch/blob/trunk/CHANGELOG.md";
    license = [ lib.licenses.gpl3Only ];
    maintainers = with lib.maintainers; [ sandarukasa ];
    mainProgram = "unisearch";
    platforms = lib.platforms.linux;
  };
}
