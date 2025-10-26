class Synapseq < Formula
  desc "Synapse-Sequenced Brainwave Generator"
  homepage "https://github.com/ruanklein/synapseq"
  version "3.2.1"
  license "GPL-2.0-only"

  on_arm do
    url "https://github.com/ruanklein/synapseq/releases/download/v3.2.1/synapseq-v3.2.1-macos-arm64.tar.gz"
    sha256 "a71aafc66cebe369fba136b4d5ed77f5a67ab10804e7a74268eaa6954f658b04"
  end

  depends_on arch: :arm64

  def install
    bin_path = Dir["**/bin/synapseq*"].find { |f| File.extname(f).empty? }
    raise "Binary not found in archive" unless bin_path

    chmod 0755, bin_path
    bin.install bin_path => "synapseq"
  end

  test do
    system "#{bin}/synapseq", "-version"
  end
end
