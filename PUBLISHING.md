# Publishing Guide: WebP Converter CLI

This guide will walk you through publishing your CLI app so users can install it via Homebrew.

## Prerequisites

Before you begin, you'll need:
- A GitHub account (for hosting your Homebrew formula)
- A PyPI account (https://pypi.org/account/register/)
- Your package must be in a public GitHub repository

## Step 1: Publish to PyPI

### 1.1 Update your email in pyproject.toml

Edit [pyproject.toml](pyproject.toml) and replace `your.email@example.com` with your actual email address.

### 1.2 Create a LICENSE file

Create a `LICENSE` file in the root of your project. For MIT License:

```bash
cat > LICENSE << 'EOF'
MIT License

Copyright (c) 2025 Fawwaz

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
EOF
```

### 1.3 Install build tools

```bash
pip install build twine
```

### 1.4 Build your package

```bash
python -m build
```

This will create two files in the `dist/` directory:
- `webp-converter-cli-0.0.1.tar.gz` (source distribution)
- `webp_converter_cli-0.0.1-py3-none-any.whl` (wheel)

### 1.5 Test your package locally

```bash
# Install from the wheel
pip install dist/webp_converter_cli-0.0.1-py3-none-any.whl

# Test the CLI
webp-convert --version
```

### 1.6 Upload to PyPI

```bash
# Upload to PyPI (you'll be prompted for your PyPI credentials)
python -m twine upload dist/*
```

For testing, you can upload to TestPyPI first:
```bash
python -m twine upload --repository testpypi dist/*
```

## Step 2: Create a Homebrew Formula

Once your package is on PyPI, create a Homebrew formula.

### 2.1 Create a tap repository

A "tap" is a GitHub repository for Homebrew formulas. Create a new repository called:
```
homebrew-webp-converter
```

The naming is important: it must start with `homebrew-`.

### 2.2 Use the formula file from this repository

I've already created a complete formula file for you: [webp-convert.rb](webp-convert.rb)

Copy this file to your `homebrew-webp-converter` repository. This formula includes:
- All necessary dependencies for Pillow (jpeg-turbo, libpng, libtiff, little-cms2, webp, freetype, zlib)
- Proper environment variables to help Pillow find the image libraries
- All Python dependencies with correct SHA256 hashes

The key additions that fix the Pillow compilation issue are:

```ruby
depends_on "jpeg-turbo"
depends_on "libpng"
depends_on "libtiff"
depends_on "little-cms2"
depends_on "webp"
depends_on "freetype"
depends_on "zlib"

def install
  # Set environment variables for Pillow to find image libraries
  ENV.append "CFLAGS", "-I#{Formula["jpeg-turbo"].opt_include}"
  ENV.append "CFLAGS", "-I#{Formula["libpng"].opt_include}"
  # ... etc

  virtualenv_install_with_resources
end
```

### 2.3 The formula is already complete!

The [webp-convert.rb](webp-convert.rb) file already has all the correct SHA256 hashes and dependencies. Just copy it to your tap repository!

### 2.4 Optional: Generate formula automatically (for future updates)

There's a tool that can generate the formula for you:

```bash
pip install homebrew-pypi-poet

# Generate the formula
poet webp-converter-cli > webp-convert.rb
```

Then manually edit the generated file to adjust class name, description, etc.

## Step 3: Publish Your Tap

```bash
cd homebrew-webp-converter
git add webp-convert.rb
git commit -m "Add webp-convert formula"
git push origin main
```

## Step 4: Test Installation

Now users can install your tool with:

```bash
# Add your tap
brew tap andriawan24/webp-converter

# Install the formula
brew install webp-convert
```

Test it:
```bash
webp-convert --version
```

## Step 5: Update README

Update your main project's README to include Homebrew installation instructions.

## Future Updates

When you release a new version:

1. Update version in [src/__init__.py](src/__init__.py)
2. Update version in [pyproject.toml](pyproject.toml)
3. Rebuild and upload to PyPI:
   ```bash
   python -m build
   python -m twine upload dist/*
   ```
4. Update your Homebrew formula:
   - Change the `url` to point to the new version
   - Update the `sha256` hash
   - Commit and push the changes

## Alternative: Simpler Approach with pipx

If Homebrew seems too complex, you can recommend users install via pipx:

```bash
# Install pipx first
brew install pipx
pipx ensurepath

# Install your tool
pipx install webp-converter-cli
```

This is simpler and doesn't require maintaining a Homebrew formula.

## Resources

- [Homebrew Formula Cookbook](https://docs.brew.sh/Formula-Cookbook)
- [Python for Formula Authors](https://docs.brew.sh/Python-for-Formula-Authors)
- [PyPI Packaging Guide](https://packaging.python.org/tutorials/packaging-projects/)
