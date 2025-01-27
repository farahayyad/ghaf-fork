# Copyright 2022-2023 TII (SSRC) and the Ghaf contributors
# SPDX-License-Identifier: Apache-2.0
#
{
  config,
  lib,
  ...
}: let
  cfg = config.ghaf.profiles.debug;
in
  with lib; {
    options.ghaf.profiles.debug = {
      enable = mkEnableOption "debug profile";
    };

    config = mkIf cfg.enable {
      # Enable default accounts and passwords
      ghaf = {
        users.accounts.enable = true;
        # Enable development on target
        development = {
          nix-setup.enable = true;
          # Enable some basic monitoring and debug tools
          debug.tools.enable = true;
          # Let us in.
          ssh.daemon.enable = true;
        };

        hardware.nvidia.orin.optee = {
          xtest = true;
          pkcs11-tool = true;
        };
      };
    };
  }
