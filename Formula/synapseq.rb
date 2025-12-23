class Synapseq < Formula
  desc "Synapse-Sequenced Brainwave Generator"
  homepage "https://github.com/ruanklein/synapseq"
  version "3.5.0"
  license "GPL-2.0-only"

  base_url = "https://github.com/ruanklein/synapseq/releases/download/v#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/synapseq-v#{version}-macos-arm64.tar.gz"
      sha256 "cfc07fda6af90d1087a560b982e5e9b66648521e05c7ba7813cb0c4c4fb9ba2c"
    else
      odie "SynapSeq is only available for macOS ARM64 (Apple Silicon)."
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "#{base_url}/synapseq-v#{version}-linux-arm64.tar.gz"
      sha256 "95de34ed0d6bb5f8513ce238e587fbd583e18040cb250dfd54e6e695b1cfa1fb"
    elsif Hardware::CPU.intel?
      url "#{base_url}/synapseq-v#{version}-linux-amd64.tar.gz"
      sha256 "70c924270c18615ca2b4925409dea383ff33689536102ab5fb444acb9a9a1a85"
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