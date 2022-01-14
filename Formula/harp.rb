# typed: false
# frozen_string_literal: true

# Code generated by Harp build tool
class Harp < Formula
  desc "Secret management toolchain"
  homepage "https://github.com/elastic/harp"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/elastic/harp/releases/download/cmd%2Fharp%2Fv0.2.4/harp-darwin-amd64.tar.gz"
      sha256 "c6f097b7c17ec91d5ce316ec4d0cd1bf796491e8a2547481d92f709dbe4964dd"
    elsif Hardware::CPU.arm?
      url "https://github.com/elastic/harp/releases/download/cmd%2Fharp%2Fv0.2.4/harp-darwin-arm64.tar.gz"
      sha256 "32d098c67d7606caa3b1e27c2829ffff6c829e18aeb67718b61cd5a2d969c342"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://github.com/elastic/harp/releases/download/cmd%2Fharp%2Fv0.2.4/harp-linux-amd64.tar.gz"
        sha256 "b29e5e1691be09957d4869d19ec03b2a823c3b41fd59b853938a816fceb93c0c"
      end
    elsif Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://github.com/elastic/harp/releases/download/cmd%2Fharp%2Fv0.2.4/harp-linux-arm64.tar.gz"
        sha256 "c9fc23bcb67570cf5d19202f17248bf2bb67e0bc4f8b81f85ac7581986adba18"
      else
        url "https://github.com/elastic/harp/releases/download/cmd%2Fharp%2Fv0.2.4/harp-linux-arm7.tar.gz"
        sha256 "efafeb640d0e0574824dde7ba024345ed871528435957a8d6dfbe98fbd1c3964"
      end
    end
  end

  conflicts_with "harp-fips", because: "harp-fips also ships a 'harp' binary"

  def install
    ENV.deparallelize

    # Install binaries
    if OS.mac? && Hardware::CPU.arm?
      bin.install "harp-darwin-arm64" => "harp"
    elsif OS.mac?
      bin.install "harp-darwin-amd64" => "harp"
    elsif OS.linux?
      bin.install "harp-linux-amd64" => "harp"
    end

    # Final message
    ohai "Install success!"
  end

  def caveats
    <<~EOS
      If you have previously built harp from source, make sure you're not using
      $GOPATH/bin/harp instead of this one. If that's the case you can simply run
      rm -f $GOPATH/bin/harp
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/harp version")
  end
end
