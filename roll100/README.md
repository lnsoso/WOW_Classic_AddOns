# 插件开发从入门到放弃 - 如何开发一个 ROLL 点 一定是100的插件 

大家学习插件开发一定要有动力，为了让大家在学习开发插件的同时有所收获，我今天教大家写一个让你ROLL 总是100 的插件

_注意：本文例子是在怀旧服 上讲解的_

## 1. 前提

 1. 你需要知道如何安装单体插件，也就是能找到插件目录
 1. 会使用记事本复制和粘贴
 1. 请一步一步跟随教程，新手照着做就会突然领悟插件开发

Q: 难道不需要有编程知识吗？

A: 不需要，进阶时候才需要

## 2. Hello world

那么我们开始吧，就想一般程序一样先学习写 Hello world

ちょどう，作为一个程序员，我听过你门都是从 `0` 开始计数了， 你从 `1` 开始不是很弱吗？

 _你也许听说过 WOW 使用 lua 作为开发语言，所以请你记住 lua 的数组是从 `1` 开始计数的。_

现在请跟一步一步做

 1. 打开游戏
 1. 打开聊天窗口
 1. 复制 `/script print('hello world')`， 并贴进去

是不是感觉很神奇，你已经完成了 hello world 的部分，成功执行了一句 lua 
不过和你平时用的插件不一样，连个文件夹都没有啊……

## 3. 我也要有文件夹

现在我们开始 把 刚才的 `hello world` 放到文件夹里吧

 1. 找到怀旧服插件文件夹 `World of Warcraft\_classic_\Interface\AddOns`
 1. 新建一个叫 `roll100` 的文件夹， 记住不能自己不要乱起名字 不然没法roll  100点了
 1. 在文件夹内新建一个叫 `roll100.toc` 的文本文件 ，注意扩展名是 `.toc` 不是 `.toc.txt`
    
    然后把我这个魔法贴进去 

    ```
    ## Interface: 11302
    ## Title: ROLL100

    core.lua
    ```

 1. 然后创建一个叫 `core.lua` 的文本文件，注意扩展名是 `.lua` 不是 `.lua.txt`

    然后把我这个魔法贴进去

    ```
    print('hello world')
    ```

 1. 现在你需要重新启动游戏，你会在你的插件列表里看到 ROLL100，就说明你成功，如果没有，那么说明之前的环节有错误，请你重新做一次，看看是不是哪里有疏漏

 ## 4. 在roll100之的魔术之前，先学习写自己的名字


 1. 现在 你 需要 打开刚才的 `core.lua` 并把内容换成这个

    ```
    local name = UnitName('player')
    print(name)
    ``` 

 1. 再游戏窗口聊天窗口里输入 `/reload`
 1. 这个时候，你应该看到你角色的名字
 
 1. 是不是很厉害，我们进阶一下把文件改成这个样子

    ``` 
    local name = UnitName('player')
    print(RANDOM_ROLL_RESULT:format(name, 100, 1, 100))
    ```
 1. 现在再次 `/reload`

  是不是发现 你 用 白字roll 了 100点？ 你可以试着调节刚才的数字，并 不断的 `/reload` 来观察变化，这就是一般的插件 开发的过程
   
   * 修改代码
   * `/reload`
   * 在游戏中测试

## 5. 学习一个循环

这个是一些程序的知识，如果你不想理解，没有关系，把我的 魔法 代码贴到 `core.lua` 中试验下

  ```
    local name = UnitName('player')
    for i = 1, 100 do
        local msg = RANDOM_ROLL_RESULT:format(name, i, 1, 100)
        print(msg)
    end
  ```

是不是感觉 你 roll 的很多次呢？

进阶学习：
 * `UnitName` 是一个 WOW API，WOW提供的很多 API 帮你做很多事情，如果你想了解更多API 可以到 <https://wowwiki.fandom.com/wiki/Category:World_of_Warcraft_API> 去查找
 * `RANDOM_ROLL_RESULT` 是WOW 中的一个常量，就是ROLL点时候的文字，这里先不展开如何获得这个常量的名字，以后有机会再解释为什么我知道

## 6. 我需要黄色的 ROLL 点

还是一样 我们再改进一下我们的代码让他变黄

  ```
    local name = UnitName('player')
    for i = 1, 100 do
        local msg = RANDOM_ROLL_RESULT:format(name, i, 1, 100)
        local info = ChatTypeInfo["SYSTEM"]
        DEFAULT_CHAT_FRAME:AddMessage(msg, info.r, info.g, info.b, info.id)
    end
  ```

现在是不是 感觉自己很黄很暴力呢？

进阶学习：

 * `DEFAULT_CHAT_FRAME.AddMessage` 就是你默认窗口输出文字的函数你也可以把它当成 API 来看待 方便理解

## 7. 那么替换掉我ROLL的不是100的点数吧

现在贴上去我的 魔法 代码吧

```
local old = DEFAULT_CHAT_FRAME.AddMessage

DEFAULT_CHAT_FRAME.AddMessage = function(self, msg, ...) 

    local name = UnitName('player')
    for i = 1, 100 do
        if RANDOM_ROLL_RESULT:format(name, i, 1, 100) == msg then
            msg = RANDOM_ROLL_RESULT:format(name, 100, 1, 100)
        end

    end

    old(self, msg, ...)
end
```

`/reload` 一下 再次 `/rnd` 看看效果

 全文完

## 8. …… 你就不解释一下，还有好多地方不懂

如果你现在每次都能roll 100，那么你已经成功了，小心被封号的说……

步骤 6，7已经开始变得困难起来，所以今天并不要求理解，如果你能把插件开发的基本步骤学会，今天就成功了。

推荐延申阅读：
 
 * 步骤7里边的lua 语法：<http://www.lua.org/pil/contents.html>
 * wow api wiki <https://wowwiki.fandom.com/wiki/Category:World_of_Warcraft_API>

