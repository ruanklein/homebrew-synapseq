class Synapseq < Formula
  desc "Synapse-Sequenced Brainwave Generator"
  homepage "https://github.com/ruanklein/synapseq"
  version "3.2.1"
  license "GPL-2.0-only"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ruanklein/synapseq/releases/download/v3.2.1/synapseq-v3.2.1-macos-arm64.tar.gz"
      sha256 "a71aafc66cebe369fba136b4d5ed77f5a67ab10804e7a74268eaa6954f658b04"
    else
      odie "SynapSeq is only available for macOS ARM64 (Apple Silicon)."
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ruanklein/synapseq/releases/download/v3.2.1/synapseq-v3.2.1-linux-arm64.tar.gz"
      sha256 "ae4dc5fff0aea1c447dd6a6273a552378d2d83289878dbcc71e32f619ec3b676"
    elsif Hardware::CPU.intel?
      url "https://github.com/ruanklein/synapseq/releases/download/v3.2.1/synapseq-v3.2.1-linux-amd64.tar.gz"
      sha256 "c6cc65c59c31b8fdb906fde461ce19fb0806670536dbceebec5f46a91d16e16a"
    else
      odie "Unsupported Linux architecture for SynapSeq."
    end
  else
    odie "Unsupported operating system for SynapSeq."
  end

  def install
    bin_path = Dir["**/bin/synapseq*"].find { |f| File.basename(f) !~ /\.sha256$/ }
    raise "Binary not found in archive" unless bin_path

    chmod 0755, bin_path
    bin.install bin_path => "synapseq"

    manpage = Dir["**/man/synapseq.1"].first
    man1.install manpage if manpage

    pkgshare.install "samples" if Dir.exist?("samples")
    pkgshare.install "scripts" if Dir.exist?("scripts")
    pkgshare.install "contrib" if Dir.exist?("contrib")

     doc.install Dir["*.txt"] if Dir["*.txt"].any?
  end

  def caveats
    <<~EOS
      SynapSeq was successfully installed!

      Additional resources were installed to:
        #{opt_pkgshare}

      The following directories are available:
        - samples => example .spsq sessions and structured formats
        - scripts => helper scripts and streaming examples
        - contrib => community presets and advanced sequences

      To learn how to use SynapSeq, read the manual page:
        man synapseq

      Or check out the usage documentation:
        less #{opt_doc}/USAGE.txt
    EOS
  end

  test do
    system "#{bin}/synapseq", "-version"
  end
end
