# Homebrew Tap for SynapSeq

This repository provides the official [Homebrew](https://brew.sh) formula for installing **SynapSeq**,  
the open-source brainwave sequencing engine built in Go.

---

## Installation

Add this tap and install SynapSeq:

```bash
brew tap ruanklein/synapseq
brew install synapseq
```

After installation, verify:

```bash
synapseq -version
```

The binary will be available at:

```bash
/opt/homebrew/bin/synapseq
```

## Formula Details

This tap currently supports:

- **macOS ARM64**
- **Linux ARM64**
- **Linux x86_64**

The formula automatically downloads the precompiled binary from the [latest GitHub release](https://github.com/ruanklein/synapseq/releases/latest).

## License

SynapSeq is licensed under the [GPL-2.0](https://opensource.org/licenses/GPL-2.0) license.
