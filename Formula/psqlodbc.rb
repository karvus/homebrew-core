class Psqlodbc < Formula
  desc "Official PostgreSQL ODBC driver"
  homepage "https://odbc.postgresql.org"
  url "https://ftp.postgresql.org/pub/odbc/versions/src/psqlodbc-09.05.0400.tar.gz"
  sha256 "c9fde1c104065e81813d79eb29bb7e715d64697bdda031ff01e40e3ad59e3ad3"

  bottle do
    cellar :any
    sha256 "c9fb98f4523608e7c53fa5a82672f2fde2abdc95b985d232d046b184d3915334" => :el_capitan
    sha256 "c685c6f293b556b118d22ac2cf1171c503a90e6f7f63c543a8358aba36990495" => :yosemite
    sha256 "ab82542257f0eb7fffac4d405f6d1b246ac68adc1eabc1cfdbf4777e76fdce11" => :mavericks
  end

  head do
    url "http://git.postgresql.org/git/psqlodbc.git"
    depends_on "automake" => :build
    depends_on "autoconf" => :build
    depends_on "libtool" => :build
  end

  depends_on "openssl"
  depends_on "unixodbc"
  depends_on :postgresql

  def install
    system "./bootstrap" if build.head?
    system "./configure", "--prefix=#{prefix}",
                          "--with-unixodbc=#{Formula["unixodbc"].opt_prefix}"
    system "make"
    system "make", "install"
  end

  test do
    output = shell_output("#{Formula["unixodbc"].bin}/dltest #{lib}/psqlodbcw.so")
    assert_equal "SUCCESS: Loaded #{lib}/psqlodbcw.so\n", output
  end
end
