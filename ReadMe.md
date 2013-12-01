####命名规范
1. 静态变量、全局变量、常量使用首字母大写的驼峰式命名：`SharedInstance`  
2. 宏使用首字母大写的驼峰式 + k命名：`kCellHeight`
3. property使用首字母小写的驼峰式命名：`tableView`
4. ivar使用首字母小写的驼峰式 + _命名：`_isCompleted`
5. 类使用首字母大写的驼峰式命名 + 项目前缀：`YMMDataManager`

####项目注意事项
1. 尽量使用property（使用getter和setter），而不使用ivar。对外的property放在.h文件中，私有的放在.m文件的extension中。使用property有好几个好处：假设这个property被KVO了，如果你直接修改_xxx而不是使用self.xxx的话，需要手动调用`willChangeValueForKey:`和`didChangeValueForKey:`，相反，如果使用self.xxx的话，系统帮你处理，你不需要手动处理；可能在getter和setter中还有其他额外代码，如果直接使用_xxx，这些额外代码就不会被执行到了；getter和setter都是被高度优化过的，对性能几乎是没有影响的。
2. 使用ivar而不是property的场景：在getter和setter中；在dealloc中；在初始化（init，initWithXXX）中。
