class WebpConvert < Formula
  include Language::Python::Virtualenv

  desc "Powerful command-line tool for converting images to WebP format"
  homepage "https://github.com/andriawan24/webp-converter"
  url "https://files.pythonhosted.org/packages/31/01/6bb39aac5a602aac758c6e4c4ce6adae53f372ac8582d9565b5d68671941/webp_converter_cli-1.0.0.tar.gz"
  sha256 "1d1231673daecc32cc360c94b0a1a1f7283fc62a53deca50d2a969b48130a181"
  license "MIT"

  depends_on "python@3.14"
  depends_on "jpeg-turbo"
  depends_on "libpng"
  depends_on "libtiff"
  depends_on "little-cms2"
  depends_on "webp"
  depends_on "freetype"
  depends_on "zlib"

  resource "click" do
    url "https://files.pythonhosted.org/packages/source/c/click/click-8.2.1.tar.gz"
    sha256 "27c491cc05d968d271d5a1db13e3b5a184636d9d930f148c50b038f0d0646202"
  end

  resource "mdurl" do
    url "https://files.pythonhosted.org/packages/source/m/mdurl/mdurl-0.1.2.tar.gz"
    sha256 "bb413d29f5eea38f31dd4754dd7377d4465116fb207585f97bf925588687c1ba"
  end

  resource "pillow" do
    url "https://files.pythonhosted.org/packages/source/p/pillow/pillow-11.2.1.tar.gz"
    sha256 "a64dd61998416367b7ef979b73d3a85853ba9bec4c2925f74e588879a58716b6"
  end

  resource "pygments" do
    url "https://files.pythonhosted.org/packages/source/p/pygments/pygments-2.19.1.tar.gz"
    sha256 "61c16d2a8576dc0649d9f39e089b5f02bcd27fba10d8fb4dcc28173f7a45151f"
  end

  resource "rich" do
    url "https://files.pythonhosted.org/packages/source/r/rich/rich-14.0.0.tar.gz"
    sha256 "82f1bc23a6a21ebca4ae0c45af9bdbc492ed20231dcb63f297d6d1021a9d5725"
  end

  resource "shellingham" do
    url "https://files.pythonhosted.org/packages/source/s/shellingham/shellingham-1.5.4.tar.gz"
    sha256 "8dbca0739d487e5bd35ab3ca4b36e11c4078f3a234bfce294b0a0291363404de"
  end

  resource "typer" do
    url "https://files.pythonhosted.org/packages/source/t/typer/typer-0.16.0.tar.gz"
    sha256 "af377ffaee1dbe37ae9440cb4e8f11686ea5ce4e9bae01b84ae7c63b87f1dd3b"
  end

  resource "typing-extensions" do
    url "https://files.pythonhosted.org/packages/source/t/typing-extensions/typing_extensions-4.14.0.tar.gz"
    sha256 "6253e83a5bd4108fa2e63defaacca4a0b81a5d6eabd40a74f31bfff3edd17e56"
  end

  def install
    # Set environment variables for Pillow to find image libraries
    ENV.append "CFLAGS", "-I#{Formula["jpeg-turbo"].opt_include}"
    ENV.append "CFLAGS", "-I#{Formula["libpng"].opt_include}"
    ENV.append "CFLAGS", "-I#{Formula["libtiff"].opt_include}"
    ENV.append "CFLAGS", "-I#{Formula["little-cms2"].opt_include}"
    ENV.append "CFLAGS", "-I#{Formula["webp"].opt_include}"
    ENV.append "CFLAGS", "-I#{Formula["freetype"].opt_include}"
    ENV.append "CFLAGS", "-I#{Formula["zlib"].opt_include}"

    ENV.append "LDFLAGS", "-L#{Formula["jpeg-turbo"].opt_lib}"
    ENV.append "LDFLAGS", "-L#{Formula["libpng"].opt_lib}"
    ENV.append "LDFLAGS", "-L#{Formula["libtiff"].opt_lib}"
    ENV.append "LDFLAGS", "-L#{Formula["little-cms2"].opt_lib}"
    ENV.append "LDFLAGS", "-L#{Formula["webp"].opt_lib}"
    ENV.append "LDFLAGS", "-L#{Formula["freetype"].opt_lib}"
    ENV.append "LDFLAGS", "-L#{Formula["zlib"].opt_lib}"

    virtualenv_install_with_resources
  end

  test do
    system "#{bin}/webp-convert", "--version"
  end
end
