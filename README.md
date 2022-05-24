此项目是用openabe、openssl实现的基于CPABE策略的属性加密、生成密钥、解密以及时间复杂度分析并实现ABE和RSA的共同加密。
运行前要先安装好openabe，详情请参考https://github.com/zeutro/openabe
有些安装包的下载地址发生了变动，以及有些程序写的不太对（参考github主页的isssue处），下载openabe主页的文件安装时会报错，为了方便大家应用，我把debug后的下载文件放在这里，大家可以根据需要安装，链接：https://pan.baidu.com/s/1T8qnBPk7clwVd1v6C5Jcpw?pwd=25z8 提取码：25z8。
安装可以参考解压后docs文件夹里的libopenabe-v1.0.0-api-doc文件，以 Debian/Ubuntu-based Linux为例，推荐ubuntu 16.04和ubuntu20.04（我们在这两个版本中跑通过），安装分为以下几步：
cd libopenabe-1.0.0/
sudo -E ./deps/install_pkgs.sh
. ./env
make
make test
安装完成后要在openabe-master/cli文件夹中运行（因要要用到oabe_enc等函数）。在虚拟机和云服务器运行时抖动较大，尤其是当本地虚拟机配置较低时，因此程序迭代运行了1000次，后续可编程序去除其中抖动明显很大的数据、取平均等数据处理并画图，或者可根据需要将1000次改成100次等。

CPABE.sh主要是由openabe实现，代码中包括以下四步，CPABE_TST.SH是用来测试时间复杂度的shell程序。
（1）设置CP-ABE模式

（2）使用属性加密

（3）使用属性产生秘钥

（4）使用秘钥解密

rsa_publickeyencrypt.sh实现了RSA和Openabe的共同加密，采取传统的公钥加密私钥解密的方式，rsa_publickeyencrypt_TST.sh是测试时间复杂度的shell程序，RSA是用openssl内置的函数实现，主要可以分为以下几步：

（1）生成私钥

（2）生成公钥

（3）用Openabe对公钥加密（基于属性值）

（4）生成openabe的密钥

（5）使用openabe的密钥对公钥解密

（6）使用RSA公钥加密

（7）使用RSA私钥解密

rsa_privatekeyencrypt.sh是采用私钥加密、公钥解密的方式。前文中公钥经过Openabe加密，通过正确的属性值解密才能够获取到，不必担心私钥加密后大家都拥有公钥每个人都拥有公钥，只有拥有正确属性才能够解密获得公钥。因此这里可以通过数字签名的方式实现私钥加密、公钥解密，步骤氛围四步：

（1）生成私钥

（2）生成公钥

（3）私钥解密

（4）公钥加密
