{
  lib,
  buildPythonApplication,
  uv-build,
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
in
buildPythonApplication rec {
  name = "unisearch";
  pyproject = true;

  src = ./.;

  build-system = [
    uv-build
  ];

  pythonImportsCheck = [
    "unisearch"
  ];

  # TODO: provide unicode data
  # TODO: install man pages
  # TODO: zgrep and stuff

  passthru = {
    inherit unicode-data;
  };

  meta = {
    description = "CLI tool to display Unicode character properties";
    homepage = "https://github.com/SandaruKasa/unisearch";
    changelog = "https://github.com/SandaruKasa/unisearch/blob/${src.rev}/CHANGELOG.md";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [ sandarukasa ];
    mainProgram = "unisearch";
    platform = lib.platforms.linux;
  };
}
