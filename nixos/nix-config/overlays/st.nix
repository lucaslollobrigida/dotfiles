self: super:
{
  st = super.st.overrideAttrs(oldAttrs: {
    src = builtins.fetchGit {
      url = https://github.com/lucaslollobrigida/st.git;
    };
  nativeBuildInputs = oldAttrs.nativeBuildInputs ++ [ super.harfbuzzFull ];
  # buildInputs = oldAttrs.buildInputs ++ [ harfbuzzFull ];
});
}
