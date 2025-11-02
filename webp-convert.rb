class WebpConvert < Formula
    include Language::Python::Virtualenv
  
    desc "Powerful command-line tool for converting images to WebP format"
    homepage "https://github.com/andriawan24/webp-converter"
    url "https://files.pythonhosted.org/packages/31/01/6bb39aac5a602aac758c6e4c4ce6adae53f372ac8582d9565b5d68671941/webp_converter_cli-1.0.0.tar.gz"
    sha256 "1d1231673daecc32cc360c94b0a1a1f7283fc62a53deca50d2a969b48130a181"
    license "MIT"
  
    depends_on "python@3.11"
  
    resource "click" do
      url "https://files.pythonhosted.org/packages/source/c/click/click-8.2.1.tar.gz"
      sha256 "27c491cc05d968d271d5a1db13e3b5a184636d9d930f148c50b038f0d0646202"
    end
  
    resource "pillow" do
      url "https://files.pythonhosted.org/packages/source/p/pillow/pillow-11.2.1.tar.gz"
      sha256 "a64dd61998416367b7ef979b73d3a85853ba9bec4c2925f74e588879a58716b6"
    end
  
    resource "rich" do
      url "https://files.pythonhosted.org/packages/source/r/rich/rich-14.0.0.tar.gz"
      sha256 "82f1bc23a6a21ebca4ae0c45af9bdbc492ed20231dcb63f297d6d1021a9d5725"
    end
  
    resource "typer" do
      url "https://files.pythonhosted.org/packages/source/t/typer/typer-0.16.0.tar.gz"
      sha256 "af377ffaee1dbe37ae9440cb4e8f11686ea5ce4e9bae01b84ae7c63b87f1dd3b"
    end
  
    def install
      virtualenv_install_with_resources
    end
  
    test do
        system "#{bin}/webp-convert", "--version"
    end
end