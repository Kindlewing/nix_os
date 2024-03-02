{pkgs, ...}:

{
	programs.nix-ld = {
		enable = true;
		libraries = with pkgs; [
			stdenv.cc.cc
			zlib
			fuse3
			icu
			zlib
			nss
			openssl
			curl
			expat
		];
	};
}
