self: prev: {
  neovim-unwrapped = (prev.neovim-unwrapped.override { lua = self.luajit; }).overrideAttrs(oldAttrs: {
    cmakeBuildType="debug";
    cmakeFlags = oldAttrs.cmakeFlags ++ [ "-DMIN_LOG_LEVEL=0" ];

    version = "master";
    src = builtins.fetchGit {
      url = https://github.com/neovim/neovim.git;
    };

    nativeBuildInputs = oldAttrs.nativeBuildInputs ++ [
      # self.pkgs.valgrind

      # testing between both
      self.pkgs.ccls
      self.pkgs.clang-tools  # for clangd
    ];

    buildInputs = oldAttrs.buildInputs ++ [
      self.pkgs.icu  # for treesitter unicode/ptypes.h
      self.pkgs.utf8proc
    ];

    # export NVIM_PROG
    # https://github.com/neovim/neovim/blob/master/test/README.md#configuration
    shellHook = oldAttrs.shellHook + ''
      export NVIM_PYTHON_LOG_LEVEL=DEBUG
      export NVIM_LOG_FILE=/tmp/log
      # export NVIM_PYTHON_LOG_FILE=/tmp/log
      export VALGRIND_LOG="$PWD/valgrind.log"
      export NVIM_TEST_PRINT_I=1
      export NVIM_TEST_MAIN_CDEFS=1
      echo "To run tests:"
      echo "VALGRIND=1 TEST_FILE=test/functional/core/job_spec.lua TEST_TAG=env make functionaltest"
    '';
  });
}
