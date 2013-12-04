####命名规范
1. 静态变量、全局变量、常量使用首字母大写的驼峰式命名：`SharedInstance`  
2. 宏使用下划线分割全大写：`CELL_HEIGHT`,
3. property使用首字母小写的驼峰式命名：`tableView`
4. ivar使用首字母小写的驼峰式 + _命名：`_isCompleted`
5. 类使用首字母大写的驼峰式命名 + 项目前缀：`YMMDataManager`

####项目注意事项
1. 尽量使用property（使用getter和setter），而不使用ivar。对外的property放在.h文件中，私有的放在.m文件的extension中。使用property有好几个好处：假设这个property被KVO了，如果你直接修改_xxx而不是使用self.xxx的话，需要手动调用 `willChangeValueForKey:` 和 `didChangeValueForKey:` ，相反，如果使用self.xxx的话，系统帮你处理，你不需要手动处理；可能在getter和setter中还有其他额外代码，如果直接使用_xxx，这些额外代码就不会被执行到了；getter和setter都是被高度优化过的，对性能几乎是没有影响的。
2. 使用ivar而不是property的场景：在getter和setter中；在dealloc中；在初始化（init，initWithXXX）中。
3. 每个实例都要用到的资源（UIFont/NSDataFormatter），统一在一个class层面的方法中初始化（例如：+ (void)initialize）并存在一个static的变量中（例：`static UIFont *titleFont = nil;`），可以参看TableViewPerformance项目中的CustomDrawnCell。
4. Cell的数据绑定尽量不要在controller里面进行。一来，可以让controller里面的代码更少，更容易阅读和维护；二来，Cell如果需要重用，也不用重复这个数据绑定代码。如果是自定义的Cell，可以开放一个数据绑定方法让controller调用：`- (void)bind:(Feed *)feedToBeDisplayed`，如果是系统的Cell，可以用Category来添加bind方法。
5. 如果需要Cache，尽量使用NSCache，而不是NSMutableDictionary，原因见收藏夹。
6. 用NSAssert(NSAssert1, NSAssert2...NSAssert5等)来做条件判断，项目中已经设置在debug中启用，在release中禁用。典型的一个用途：判断服务器返回是否正确，例如，某个API服务器必须返回20条数据，那就可以写一个NSAssert来判断，可以简化很多测试工作，用法见收藏夹。
7. 使用自定义的log(YMMLOG)，不要使用NSLog，已经加了编译选项进行条件编译了，也即：debug的时候会包含log代码，release的时候不会包含log代码。


####版本号
1. 版本号一般来说有三个数字：4.5.2。4代表大版本，5代表小版本，2代表maintenance release。我们使用两个数字的版本号，即大版本号和小版本号，例如：1.0。版本号会显示在App Store的App页面中。
2. build号：represents an iteration (released or unreleased) of the bundle。我们使用三个数字的build号，例如：1.0.11。build号和版本号有一个对应关系，前两位代表版本号。所以，1.0.11指的是1.0版本后的第11次build。等到状况合适，就要升级版本号，例如1.0版本后的第19次build完成后可以发布1.1版本，那么1.0.19后的下一个release的对应版本号和build号就是：1.1（version number）和1.1.0(build number)，**另外注意，1.1版本后的第一个build号是1.1.1而不是1.1.0，因为1.1.0已经被用掉了。**。iTunes会根据build号来同步测试App，所以，build号和App测试有关。