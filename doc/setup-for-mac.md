
# macで構築するときのTips

mac OS上にVirtualBoxとVagrantを利用してUbuntu18.04をVMとして動かして、このVMで開発するときのTips

### bento/ubuntu18.04にインストールされていないもの

basd4g/kozosをcloneする前に、以下を実行する。

```
sudo apt update
sudo apt install gcc
sudo apt install cu
sudo apt install lrzsz
```

### [Virtual Box (vagrantを含む)でUSB機器を認識させる方法](https://blog.yammer.fun/article/virtualBoxUSB/)

#### 1. Extension Packの導入

[Download VirtualBox](https://www.virtualbox.org/wiki/Downloads)からOracle VM VirtualBox Extension Packをダウンロードする。

最新版は、VirtualBox x.x.x Oracle VM VirtualBox Extension Packの1行下のAll supported platformsがリンクになっている。
バージョンは自分のPCにインストールされているVirtualBoxに合わせること。
違うバージョンのものはインストールに失敗する。

[VirtualBox6.0のDownloadページ](https://www.virtualbox.org/wiki/Download_Old_Builds_6_0)や[VirtualBox5.2のDownloadページ](https://www.virtualbox.org/wiki/Download_Old_Builds_5_2)から、各バージョンのExtention Packがダウンロードできる。

ダウンロードしたファイルをダブルクリックすると、VirtualBoxのウィンドウが立ち上がりインストールが始まる。

#### 2. USBデバイスフィルターに機器を追加

Oracle VM VirtualBoxマネージャーを開き、目的のVMにカーソルを合わせて右クリック -> 設定 を開く。

ポート -> USB -> USBデバイスフィルター -> 右横の+アイコンをクリック -> 目的のデバイスを選択する。

#### 3. VMを起動(再起動)する

### cuで接続する際にパーミッションを変更する

```
$ cu -l ttyUSB0 -s 9600
cu: open (/dev/ttyUSB0): Permission denied
cu: ttyUSB0: Line in use
# パーミッションで弾かれた

$ ls -l /dev/ttyUSB0
# パーミッションを確認

$ sudo chmod o+wr /dev/ttyUSB0
# 一般ユーザにも権限を付与
