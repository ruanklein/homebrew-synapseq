class Synapseq < Formula
  desc "Synapse-Sequenced Brainwave Generator"
  homepage "https://github.com/ruanklein/synapseq"
  version "3.5.1"
  license "GPL-2.0-only"

  base_url = "https://github.com/ruanklein/synapseq/releases/download/v#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/synapseq-v#{version}-macos-arm64.tar.gz"
      sha256 "5a76a821596efe5afcbcaa9cbe7b692802cd1c9b6daa24578c17cfed9fa10603"
    else
      odie "SynapSeq is only available for macOS ARM64 (Apple Silicon)."
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "#{base_url}/synapseq-v#{version}-linux-arm64.tar.gz"
      sha256 "fea99811089dd3fb9c91f2998202d852f515466d5bdaa942a8a64dd12e0bf492"
    elsif Hardware::CPU.intel?
      url "#{base_url}/synapseq-v#{version}-linux-amd64.tar.gz"
      sha256 "d7b0d0432809f259659eb4224e9b4bee2ce065a69004c07d4ce2c15193907ba1"
    else
      odie "Unsupported Linux architecture for SynapSeq."
    end
  else
    odie "Unsupported operating system for SynapSeq."
  end

  def install
    # Locate the SynapSeq binary (ignore .sha256 files)
    bin_path = Dir["synapseq*"].find { |f| File.basename(f) !~ /\.sha256$/ }
    raise "Binary not found in archive" unless bin_path

    chmod 0755, bin_path
    bin.install bin_path => "synapseq"
  end

  def caveats
    <<~EOS
      For documentation and examples, visit:
        https://github.com/ruanklein/synapseq
    EOS
  end

  test do
    system "#{bin}/synapseq", "-version"
  end
end