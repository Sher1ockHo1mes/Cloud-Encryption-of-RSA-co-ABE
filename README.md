CPABE.sh是用openabe实现的基于CPABE策略的属性加密、生成密钥、解密的时间复杂度分析。运行前要先安装好openabe，详情请参考https://github.com/zeutro/openabe
最终要在openabe-master/cli文件中运行（因要要用到oabe_enc等函数）。因为在虚拟机和云服务器运行时抖动较大，尤其是当本地虚拟机配置较低时，因此程序迭代运行了1000次，后续可编程序去除其中抖动明显很大的数据、取平均等数据处理并画图，可根据个人需要将1000次改成100次等。

rsa_publickeyencrypt.sh实现了RSA和Openabe的混合加密并测试时间复杂度，RSA是用openssl内置的函数实现，主要可以分为一下几步。

（1）产生私钥

（2）产生公钥

（3）用Openabe对公钥加密（基于属性值）

（4）产生Openabe的密钥

（5）使用Openabe的密钥对公钥解密

（6）使用RSA公钥加密

（7）使用RSA私钥解密

rsa_privatekeyencrypt.sh是使用openssl使用私钥加密、公钥解密。前文中公钥经过Openabe加密的，通过正确的属性值解密才能够获取到，因此这里可以通过数字签名的方式使用私钥加密、公钥解密，步骤氛围四步：
（1）生成私钥

（2）生成公钥

（3）私钥解密

（4）公钥加密
