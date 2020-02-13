# 欢迎使用  上海海事大学 LaTeX 学位论文模板(SHMTUThesis - LaTeX )

> 本项目是上海海事大学学位论文（<font color="red">非官方</font>）LaTeX 模板文档。
>
> 目前该模板仅适用于*信息工程学院*的**硕士生**。（未参考其他学院的论文要求）

## 项目介绍

&emsp; &emsp; 本项目模板文档是由LaTeX 语法编写，模板的主要内容是关于上海海事大学信息工程学院（SHMTU—CIE）硕士研究生毕业论文的基本框架。模板里包含了排版中常用的例子，包括公式、表格、算法、参考文献等。 用户可以参考或者直接基于此示例文档撰写论文。模板预览效果参看`main.pdf`。

## 环境依赖

&emsp;&emsp; 本模板仅支持XeTeX引擎——XeLaTeX，字符编码仅支持UTF-8。

## 使用方法

> 目前已在`macOS`、`Linux`、`Windows`环境下编译运行通过，由于测试用例较少有任何问题欢迎在`Requests`中提出。
>
> 编译设置主要是将排版引擎（Typeset Engine）设置为`XeLaTeX`；文献引擎（Bibliography Engine）设置为`Biber`。
>
> 设置完毕后进行编译即可得到PDF文件。

&emsp;&emsp; 注意：如果编译过程中出现XITS、LISU和YOUYUAN字体缺失错误，请在本项目的`fonts`目录中安装字体。

* #### macOS用户

  &emsp;&emsp; 推荐下载[texpad](https://www.texpad.com/)、[texlive](https://www.tug.org/texlive/)或其他类型的LaTeX编辑器使用，也可以下载安装好LaTeX相关环境后，使用项目中提供的`compile.sh`脚本进行编译。以texpad编辑器为例：
  
  ​	1、首先使用编辑器打开该模版的`main.tex`文件；
  
  ​	2、点击左上角的设置按钮，将`Built-in TexpadTex Typesetter`修改为`External Typesetter`；
  
  ​	3、点击`Typeset Configuration`中的`General`设置`Document Format`为`LaTeX`，然后再将`Typeset Engine`修改为`XeLaTeX`；
  
  ​	4、再点击`Bibliographies`设置`Bibliography Engine`为`Biber`；
  
  ​	5、最后点击编译按钮即可。
  
* #### Linux用户

  1. **命令行运行**

	&emsp;&emsp;  在``SHMTUThesis``目录下运行``./compile.sh run``，等待论文生成即可。
	
	&emsp;&emsp;  注意：需要安装``latexmk``，``sudo apt-get install latexmk``。
	
	2. **VSCode**
	
	   如果使用VSCode编辑器（安装了``Latex WorkShop``插件）：
	
	   * 打开设置：点击左上角``File``，点击``Preferences -> Settings``；
	   * 输入``latex``，点击``Edit in setting.json``；
	   * 在``latex-workshop.latex.tools``和``latex-workshop.latex.recipes``下配置``biber``：
	   * 修改完配置后，在编辑器内打开``main.tex``；
	   * 点击左边的``TEX``按钮，选择``Build LaTex Project``，再点击``Recipe: xe->bib->xe->xe``即可。
		注意：需要安装``biber``，``sudo apt-get install biber``。


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
* #### Windows用户

  1、 首先参考这篇blog安装  LaTeX环境和编辑器——[Texlive 2019、TeXstudio](https://blog.csdn.net/Mikchy/article/details/94448707)，（补：blog中TeXstudio的官网挂了，换这个[下载链接](https://sourceforge.net/projects/texstudio/)。）；

  2、并且按照上述blog进行TeXstudio的相关配置；

  3、导入本项目文件：文件—打开—选择项目中的`main.tex`——点击打开；

  4、点击工具栏上的`构建并查看`按钮（绿色双箭头），等待结果输出。（pdf文件和一些其他文件会一同生成在项目文件夹根目录中）。

## 自定义模板文档

&emsp;&emsp; 因为实际文本内容主要在`./tex/`文件夹中，故提供此文件的相关描述，其他文件为统一的模板样式。

&emsp;&emsp; `main.tex`文件负责将每个部分组合起来形成一个完整的论文架构，所以`main.tex`文件可以调整每个子模块的位置，完成增加、删除、修改等具体操作。

```java
// 目录结构

│  abstract.tex		// 中英文摘要
│  acknowledgements.tex		// 致谢
│  float.tex		// 浮动体（即可能出现在论文任何部分的模块，包括：图、表、代码等）
│  information.tex	// 学生和导师的个人信息（一些固定文本格式里需要填写的信息）
│  introduction.tex	// 正文部分可能用到的格式信息
│  math_and_citations.tex	// 数学符号与引用文献的标注
│  publications_and_awards.tex	// （空）
│  summary.tex		// 结论
│  
├─achievements		// 成就总结
│      awards.tex	// 获奖情况
│      patents.tex	// 申请的专利
│      projects.tex	// 参与的项目
│      publications.tex	// 发表论文情况
│      
└─appendix			// 附录
        figure_flow_chart.tex	// 流程图配置文件
        flow_chart.tex			// 流程图主文件
        maxwell_equations.tex	// 论文公式范本
```

## 致谢

- 感谢 LaTeX 开源项目组；
- 感谢 [CTeX-kit](https://github.com/CTeX-org/ctex-kit)提供了 LaTeX 的中文支持；
- 感谢上海交大大学的[sjtug](https://github.com/sjtug)项目组提供的开源模版，为本模版提供了基础代码。

## 软件许可证

&emsp;&emsp; 本项目中所使用到的上海海事大学校徽、校名图片（`shmtu-badge.jpg` 等）的版权归上海海事大学所有。

&emsp;&emsp; `shmtuthesis.cls` 文档类与相关附属文件使用 [LPPL](https://www.latex-project.org/lppl.txt) 授权。

&emsp;&emsp; 其他部分使用 [Apache License 2.0](https://github.com/hellckt/SHMTUThesis/blob/master/LICENSE) 授权。

