class Synapseq < Formula
  desc "Synapse-Sequenced Brainwave Generator"
  homepage "https://github.com/ruanklein/synapseq"
  version "3.4.0"
  license "GPL-2.0-only"

  base_url = "https://github.com/ruanklein/synapseq/releases/download/v#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/synapseq-v#{version}-macos-arm64.tar.gz"
      sha256 "423695f1802011bc0e5d848cbf842ebf958f966214eae6ec9f52986026880894"
    else
      odie "SynapSeq is only available for macOS ARM64 (Apple Silicon)."
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "#{base_url}/synapseq-v#{version}-linux-arm64.tar.gz"
      sha256 "7b752e414326439b475aafe275c9c5ae5223e979b7c9d27aa369321a90e9f300"
    elsif Hardware::CPU.intel?
      url "#{base_url}/synapseq-v#{version}-linux-amd64.tar.gz"
      sha256 "821182b39c1c4e15c20e3682f2a8298714069067994b36f8ba003df75381bb57"
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