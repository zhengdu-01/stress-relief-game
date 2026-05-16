# 🎮 解压小游戏 - GitHub Pages 部署指南

## 📋 部署步骤

### 步骤1：创建GitHub账号（如果没有）
1. 访问 https://github.com/
2. 点击 "Sign up" 注册账号
3. 记住您的用户名（username）

### 步骤2：创建新的仓库（Repository）
1. 登录GitHub后，点击右上角的 "+" → "New repository"
2. 填写信息：
   - **Repository name**: `解压小游戏` 或 `stress-relief-game`（英文更好）
   - **Description**: "解压小游戏 - 星露谷风格"
   - 选择 **Public**（公开，这样GitHub Pages才能访问）
3. 点击 "Create repository"

### 步骤3：上传游戏文件
1. 在新建的仓库页面，点击 "uploading an existing file"
2. 将 `解压小游戏/游戏.html` 文件拖拽到上传区域
3. 或者点击 "choose your files" 选择文件
4. 点击 "Commit changes"

### 步骤4：启用GitHub Pages
1. 在仓库页面，点击 "Settings"（设置）
2. 滚动到 "GitHub Pages" 部分
3. 在 "Source" 下拉菜单中：
   - 选择 **Deploy from a branch**
   - Branch 选择 **main** 或 **master**
   - Folder 选择 **/ (root)**
4. 点击 "Save"

### 步骤5：等待部署
1. 等待1-2分钟，GitHub会自动部署
2. 您的游戏网址将是：
   ```
   https://[您的用户名].github.io/[仓库名]/
   ```
   例如：`https://zhangsan.github.io/解压小游戏/`

### 步骤6：打开游戏
1. 在浏览器中输入您的游戏网址
2. 或者在仓库的 Settings → GitHub Pages 部分点击网址链接

---

## 🎮 游戏玩法

### 基本操作
- **选择领导**：男领导或女领导，可输入自定义名字
- **点击攻击**：快速点击领导头像，每点击一次造成5点伤害
- **怒气槽**：每次攻击会积累10点怒气
- **释放必杀技**：怒气满后，顶部出现武器卡牌，**拖动**到领导身上释放！

### 武器效果
- 🥬 **烂菜叶**：伤害10-15（基础）
- 🥚 **臭鸡蛋**：伤害10-15（基础）
- 🔪 **菜刀**：伤害30（特殊）
- 💎 **Tiffany饰品**：伤害50，眩晕2秒（传奇）

### 胜利条件
- 60秒内打空领导血量即可获胜！

---

## 📱 分享给朋友

部署完成后，您可以：
1. **直接分享网址**：把 `https://[用户名].github.io/[仓库名]/` 发给朋友
2. **手机也能玩**：朋友在手机浏览器打开链接就能玩
3. **无需安装**：完全基于网页，跨平台兼容

---

## ❓ 常见问题

### Q: GitHub账号注册要收费吗？
**A**: 免费！个人用户可以免费使用GitHub和GitHub Pages。

### Q: 部署需要多久？
**A**: 通常1-5分钟，有时可能需要10分钟。

### Q: 朋友没有GitHub账号能玩吗？
**A**: 可以！只要有网址，任何人都能直接打开玩，不需要GitHub账号。

### Q: 如果部署失败怎么办？
**A**: 
1. 确保仓库是 Public
2. 确认文件是 `index.html` 或 `游戏.html` 在根目录
3. 检查 GitHub Pages 的 Source 设置是否正确

### Q: 如何更新游戏？
**A**: 
1. 在仓库页面点击 "Add file" → "Upload files"
2. 上传新版本的游戏.html文件
3. 等待几分钟后自动更新

---

## 🎯 推荐：重命名为 index.html

为了让链接更简洁，建议：
1. 将 `游戏.html` 改名为 `index.html` 再上传
2. 这样访问时就不需要输入文件名了：
   - 更短：`https://username.github.io/game/`
   - 不需要：`https://username.github.io/game/游戏.html`

---

## 📞 需要帮助？

如果部署过程中遇到问题，请检查：
1. 文件是否成功上传到仓库
2. GitHub Pages 是否启用
3. 仓库是否设置为 Public
4. 等待时间是否足够

祝您部署成功！🎉
