# DashBorad-progress

##汽车仪表盘

*注：demo图片为公司版权所有，请勿传播，尊重个人版权，谢谢*

a. 项目中需求，花时间简单抽取出来，有用到的还希望给个star支持一下

b. 换了很多种方式去做，进度块、指针、与渐变扇形三个部分想要单独做出任何一个都不难。关键难点在于进度块、指针、与渐变扇形的进度需要完全同步

c. 做的过程中需要注意的是NSTimer会存在很短的时间差，所以三者很难完全同步，同步了任何两者无法同步第三者，所以最终采取了稍微有点暴力的方式去实现指针的同步，详情见demo


![](https://raw.githubusercontent.com/XJShane/DashBorad-progress/master/screenshots/progress.gif)