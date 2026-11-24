class BpmnkitCli < Formula
  desc "The bpmnkit command line (alias casen): native commands, subprocess plugins, legacy Node fallback"
  homepage "https://bpmnkit.com"
  version "0.7.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/bpmnkit/bpmnkit/releases/download/bpmnkit-cli-v0.7.1/bpmnkit-cli-aarch64-apple-darwin.tar.xz"
      sha256 "c7ccf694d959db186c19273ba1998460721fbdeccd65ef2c37006cc22f45633f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/bpmnkit/bpmnkit/releases/download/bpmnkit-cli-v0.7.1/bpmnkit-cli-x86_64-apple-darwin.tar.xz"
      sha256 "f05b3b94f60c6c45b6b40c448f74ed1c3b314089a077608c764b2dbab270fe55"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/bpmnkit/bpmnkit/releases/download/bpmnkit-cli-v0.7.1/bpmnkit-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "1717c6ac85e77a304b972582ad94690fd92732750bb0fa0eb3ef3aca16f443fd"
    end
    if Hardware::CPU.intel?
      url "https://github.com/bpmnkit/bpmnkit/releases/download/bpmnkit-cli-v0.7.1/bpmnkit-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "869e90a13bbb8a832b75c89b20b1f3b379bac46b7b9cec27a0844380f84cee7f"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "bpmnkit"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "bpmnkit"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "bpmnkit"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "bpmnkit"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
