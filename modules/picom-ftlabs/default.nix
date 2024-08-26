{ picom
, fetchFromGitHub
, lib
, pcre
}:
picom.overrideAttrs (previousAttrs: rec {
  pname = "picom-ftlabs-${version}";
  version = "11.2";

  src = fetchFromGitHub {
    owner = "FT-Labs";
    repo = "picom";
    rev = "df4c6a3d9b11e14ed7f3142540babea4c775ddb1";
    hash = "sha256-FmORxY7SLFnAmtQyC82sK36RoUBa94rJ7BsDXjXUCXk=";
  };

  buildInputs = (previousAttrs.buildInputs or [ ]) ++ [ pcre ];

  # meta = {
  #   inherit (previousAttrs.meta)
  #     license
  #     platforms
  #     mainProgram
  #     longDescription
  #     ;
  #
  #   description = "Pijulius's picom fork with extensive animation support";
  #   homepage = "https://github.com/FT-Labs/picom";
  #   maintainers = with lib.maintainers; [ YvesStraten ];
  # };
})
