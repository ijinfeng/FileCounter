# FileCounter
列出项目中不同编程语言文件的分布比例

直接将[可执行文件](https://github.com/ijinfeng/FileCounter/edit/master/proj_file_counter) 放到`/usr/local/bin`目录下。

```
cp -f proj_file_counter /usr/local/bin/fcounter
```


在你需要统计的项目根目录下执行 `fcounter`，或者需要制定某个语言 `fcounter swift`

可以看到如下：

> /Users/zl/Developer/Project/你的项目根目录<br>
Total 18027 files percentile：<br>
Other 10053 55.8%<br>
Objective-C 7252 40.2%<br>
Swift 580 3.2%<br>
C/C++ 136 0.8%<br>
Shell 4 0.02%<br>
Ruby 2 0.01%<br>
