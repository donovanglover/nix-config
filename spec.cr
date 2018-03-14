require "spec"

PKGBUILD = File.read("PKGBUILD").partition("depends=(")[2].partition("\n)")[0]

describe "New Start" do
  describe "PKGBUILD" do
    context "Best Editor" do
      it "installs vim" do
        PKGBUILD.should match /\n\s*'vim'/
      end

      it "installs neovim" do
        PKGBUILD.should match /\n\s*'neovim'/
      end
    end

    context "Best Shell" do
      it "installs fish" do
        PKGBUILD.should match /\n\s*'fish'/
      end
    end

    context "Window Manager" do
      it "installs bspwm" do
        PKGBUILD.should match /\n\s*'bspwm'/
      end

      it "installs sxhkd" do
        PKGBUILD.should match /\n\s*'sxhkd'/
      end

      it "installs urxvt" do
        PKGBUILD.should match /\n\s*'rxvt-unicode'/
      end
    end

    context "Xorg" do
      it "installs mandatory requirements for xorg" do
        PKGBUILD.should match /\n\s*'xorg-server'/
        PKGBUILD.should match /\n\s*'xorg-xinit'/
      end

      it "installs necessary packages for scripts" do
        PKGBUILD.should match /\n\s*'xdo'/
        PKGBUILD.should match /\n\s*'xdotool'/
        PKGBUILD.should match /\n\s*'xorg-xprop'/
      end

      it "installs xclip" do
        PKGBUILD.should match /\n\s*'xclip'/
      end

      it "installs xcape" do
        PKGBUILD.should match /\n\s*'xcape'/
      end
    end

    context "Fonts" do
      it "installs Hack" do
        PKGBUILD.should match /\n\s*'ttf-hack'/
      end

      it "installs Fira Mono" do
        PKGBUILD.should match /\n\s*'ttf-fira-mono'/
      end

      it "installs the Noto fonts" do
        PKGBUILD.should match /\n\s*'noto-fonts'/
      end
    end

    context "Media" do
      context "Music Player" do
        it "installs mpc" do
          PKGBUILD.should match /\n\s*'mpc'/
        end

        it "installs mpd" do
          PKGBUILD.should match /\n\s*'mpd'/
        end

        it "installs ncmpcpp" do
          PKGBUILD.should match /\n\s*'ncmpcpp'/
        end
      end

      context "Image Viewer" do
        it "installs feh" do
          PKGBUILD.should match /\n\s*'feh'/
        end
      end

      context "Video Player" do
        it "installs mpv" do
          PKGBUILD.should match /\n\s*'mpv'/
        end
      end

      context "Document Viewer" do
        it "installs zathura" do
          PKGBUILD.should match /\n\s*'zathura'/
        end

        it "installs djvu support for zathura" do
          PKGBUILD.should match /\n\s*'zathura-djvu'/
        end

        it "installs pdf support for zathura" do
          PKGBUILD.should match /\n\s*'zathura-pdf-mupdf'/
        end
      end
    end

    context "Must-haves" do
      it "installs ripgrep" do
        PKGBUILD.should match /\n\s*'ripgrep'/
      end

      it "installs fzf" do
        PKGBUILD.should match /\n\s*'fzf'/
      end

      it "installs exa" do
        PKGBUILD.should match /\n\s*'exa'/
      end

      it "installs httpie" do
        PKGBUILD.should match /\n\s*'httpie'/
      end

      it "installs fd" do
        PKGBUILD.should match /\n\s*'fd'/
      end

      it "installs diff-so-fancy" do
        PKGBUILD.should match /\n\s*'diff-so-fancy'/
      end
    end
  end
end
