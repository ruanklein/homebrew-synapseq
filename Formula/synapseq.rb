class Synapseq < Formula
  desc "Synapse-Sequenced Brainwave Generator"
  homepage "https://github.com/ruanklein/synapseq"
  version "3.2.2"
  license "GPL-2.0-only"

  base_url = "https://github.com/ruanklein/synapseq/releases/download/v#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/synapseq-v#{version}-macos-arm64.tar.gz"
      sha256 "0e2be945b38b12b607c79c08c789c79cb4958aaae4a8f13d7097866b2bd9dea8"
    else
      odie "SynapSeq is only available for macOS ARM64 (Apple Silicon)."
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "#{base_url}/synapseq-v#{version}-linux-arm64.tar.gz"
      sha256 "fe863740a0cf8a53bb4d7740459fc61dea07c4c4bf6a1de9c8a11ae09a82bf06"
    elsif Hardware::CPU.intel?
      url "#{base_url}/synapseq-v#{version}-linux-amd64.tar.gz"
      sha256 "c9d62020e9b125a0f35f8067e6cd1fa44d79be22776cb51a9cea2615c2ceb151"
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
        less #{doc}/USAGE.txt
    EOS
  end

  test do
    system "#{bin}/synapseq", "-version"
  end
end
