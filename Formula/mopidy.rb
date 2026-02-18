class Mopidy < Formula
  include Language::Python::Virtualenv

  desc "Extensible music server written in Python"
  homepage "https://mopidy.com/"
  url "https://files.pythonhosted.org/packages/ed/e7/5dba73645c09b3897e26f96141a1383bdf9afd8e6c30eb7c6ed965b50710/mopidy-4.0.0a14.tar.gz"
  sha256 "7212dcf4cf3015dfb6fe1519c7d9f5b68fc9a1069f68daf395af2f4c26337ec2"
  head "https://github.com/mopidy/mopidy.git"
  revision 1

  depends_on "python@3.12"
  depends_on "gstreamer"

  resource "certifi" do
    url "https://files.pythonhosted.org/packages/71/da/e94e26401b62acd6d91df2b52954aceb7f561743aa5ccc32152886c76c96/certifi-2024.2.2.tar.gz"
    sha256 "0569859f95fc761b18b45ef421b1290a0f65f147e92a1e5eb3e635f9a5e4e66f"
  end

  resource "charset-normalizer" do
    url "https://files.pythonhosted.org/packages/63/09/c1bc53dab74b1816a00d8d030de5bf98f724c52c1635e07681d312f20be8/charset-normalizer-3.3.2.tar.gz"
    sha256 "f30c3cb33b24454a82faecaf01b19c18562b1e89558fb6c56de4d9118a032fd5"
  end

  resource "idna" do
    url "https://files.pythonhosted.org/packages/62/08/e3fc7c8161090f742f504f40b1bccbfc544d4a4e09eb774bf40aafce5436/idna-3.3.tar.gz"
    sha256 "9d643ff0a55b762d5cdb124b8eaa99c66322e2157b69160bc32796e824360e6d"
  end

  resource "pykka" do
    url "https://files.pythonhosted.org/packages/45/e9/ba139b5becd0e4bdf10a816af3fc17f788ac630159ca959d6da44d91a7be/pykka-3.1.1.tar.gz"
    sha256 "14ce223a55e6d62de6657f9b2b129e6ac785f731eccc5e26059e5254beca3cfb"
  end

  resource "requests" do
    url "https://files.pythonhosted.org/packages/9d/be/10918a2eac4ae9f02f6cfe6414b7a155ccd8f7f9d4380d62fd5b955065c3/requests-2.31.0.tar.gz"
    sha256 "942c5a758f98d790eaed1a29cb6eefc7ffb0d1cf7af05c3d2791656dbd6ad1e1"
  end

  resource "tornado" do
    url "https://files.pythonhosted.org/packages/bd/a2/ea124343e3b8dd7712561fe56c4f92eda26865f5e1040b289203729186f2/tornado-6.4.tar.gz"
    sha256 "72291fa6e6bc84e626589f1c29d90a5a6d593ef5ae68052ee2ef000dfd273dee"
  end

  resource "urllib3" do
    url "https://files.pythonhosted.org/packages/0c/39/64487bf07df2ed854cc06078c27c0d0abc59bd27b32232876e403c333a08/urllib3-1.26.18.tar.gz"
    sha256 "f8ecc1bba5667413457c529ab955bf8c67b45db799d159066261719e328580a0"
  end

  def install
    virtualenv_install_with_resources
  end

  service do
    run [opt_bin/"mopidy"]
    keep_alive true
  end

  test do
    python3 = Formula["python@3.12"].opt_bin/"python3.12"
    system python3, "-c", "import mopidy"
  end
end
