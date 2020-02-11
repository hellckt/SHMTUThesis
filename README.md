# SHMTUThesis LaTeX模板
## 欢迎使用上海海事大学 LaTeX 学位论文模板

本模板是上海海事大学学位论文（非官方）LaTeX文档。目前该模板仅适用于信息工程学院的硕士生，未参考其他学院的论文要求。

## 演示模板

演示模板演示了排版中常用的例子，包括公式、表格、算法、参考文献等。 用户可以参考或者直接基于此示例文档撰写论文。

## 模板使用

### 运行环境

本模板仅支持XeTeX引擎——XeLaTeX，字符编码仅支持UTF-8。

### 编译

目前仅在macOS中编译运行过，理论上各个系统都能兼容，但在其他系统中可能需要进行调整。编译设置主要是将排版引擎（Typeset Engine）设置为`XeLaTeX`；文献引擎（Bibliography Engine）设置为`Biber`。设置完毕后进行编译即可得到PDF文件。

注意：如果编译过程中出现XITS、LISU和YOUYUAN字体缺失错误，请在本项目的`fonts`目录中安装字体。

#### macOS用户

推荐下载[texpad](https://www.texpad.com/)、[texlive](https://www.tug.org/texlive/)或其他类型的LaTeX编辑器使用，也可以下载安装好LaTeX相关环境后，使用项目中提供的`compile.sh`脚本进行编译。

以texpad编辑器为例：

1. 首先使用编辑器打开该模版的`main.tex`文件；
2. 点击左上角的设置按钮，将`Built-in TexpadTex Typesetter`修改为`External Typesetter`；
3. 点击`Typeset Configuration`中的`General`设置`Document Format`为`LaTeX`，然后再将`Typeset Engine`修改为`XeLaTeX`；
4. 再点击`Bibliographies`设置`Bibliography Engine`为`Biber`；
5. 最后点击编译按钮即可。

#### Linux用户

**命令行运行**

1. 在``SHMTUThesis``目录下运行``./compile.sh run``，等待论文生成即可。

注意：需要安装``latexmk``，``sudo apt-get install latexmk``。

**VSCode**

如果使用VSCode编辑器（安装了``Latex WorkShop``插件）：
1. 打开设置：点击左上角``File``，点击``Preferences -> Settings``；
2. 输入``latex``，点击``Edit in setting.json``；
3. 在``latex-workshop.latex.tools``和``latex-workshop.latex.recipes``下配置``biber``：
``` json
"latex-workshop.latex.tools": [
  {
    "name": "biber",
    "command": "biber",
    "args": [
      "%DOCFILE%"
    ]
  }
]
```
``` json
"latex-workshop.latex.recipes": [
  {
    "name": "xe->bib->xe->xe",
    "tools": [
      "xelatex",
      "biber",
      "xelatex",
      "xelatex"
    ]
  }
]
```
4. 修改完配置后，在编辑器内打开``main.tex``；
5. 点击左边的``TEX``按钮，选择``Build LaTex Project``，再点击``Recipe: xe->bib->xe->xe``即可。

注意：需要安装``biber``，``sudo apt-get install biber``。

## 致谢

- 感谢 LaTeX 开源项目组；
- 感谢 [CTeX-kit](https://github.com/CTeX-org/ctex-kit)提供了 LaTeX 的中文支持；
- 感谢上海交大大学的[sjtug](https://github.com/sjtug)项目组提供的开源模版，为本模版提供了基础代码。

## 软件许可证

本项目中所使用到的上海海事大学校徽、校名图片（`shmtu-badge.jpg` 等）的版权归上海海事大学所有。

`shmtuthesis.cls` 文档类与相关附属文件使用 [LPPL](https://www.latex-project.org/lppl.txt) 授权。

其他部分使用 [Apache License 2.0](https://github.com/hellckt/SHMTUThesis/blob/master/LICENSE) 授权。

