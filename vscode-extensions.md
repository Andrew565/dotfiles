* [Auto Close Tag](https://marketplace.visualstudio.com/items?itemName=formulahendry.auto-close-tag) - Automatically add HTML/XML close tag, same as Visual Studio IDE or Sublime Text does.
* [Auto Rename Tag](https://marketplace.visualstudio.com/items?itemName=formulahendry.auto-rename-tag) - Automatically rename paired HTML/XML tag, same as Visual Studio IDE does.
* [Bracket Pair Colorizer](https://marketplace.visualstudio.com/items?itemName=CoenraadS.bracket-pair-colorizer) - A customizable extension for colorizing matching brackets
* [Code Runner](https://marketplace.visualstudio.com/items?itemName=formulahendry.code-runner) - Run code snippets and immediately see results in Output panel
* [Debugger for Chrome](https://marketplace.visualstudio.com/items?itemName=msjsdiag.debugger-for-chrome) - Debug your JavaScript code in the Chrome browser, or any other target that supports the Chrome Debugger protocol.
* [ESLint](https://marketplace.visualstudio.com/items?itemName=dbaeumer.vscode-eslint) - Integrates ESLint into VS Code.
* [IntelliSense for CSS class names](https://marketplace.visualstudio.com/items?itemName=Zignd.html-css-class-completion) - Provides CSS class name completion for the HTML class attribute based on the CSS files in your workspace. Also supports React's className attribute.
* [JavaScript (ES6) code snippets](https://marketplace.visualstudio.com/items?itemName=xabikos.JavaScriptSnippets) - Code snippets for JavaScript in ES6 syntax
* [Lorem ipsum](https://marketplace.visualstudio.com/items?itemName=Tyriar.lorem-ipsum) - Generates and inserts lorem ipsum text
* [Prettier - JavaScript formatter](https://marketplace.visualstudio.com/items?itemName=esbenp.prettier-vscode) - VS Code plugin for prettier/prettier
* [React/Redux/react-router Snippets](https://marketplace.visualstudio.com/items?itemName=discountry.react-redux-react-router-snippets) - React Ecosystem code snippets all in one
* [TODO Highlight](https://marketplace.visualstudio.com/items?itemName=wayou.vscode-todo-highlight) - highlight TODOs, FIXMEs, and any keywords, annotations...
* [vscode-icons](https://marketplace.visualstudio.com/items?itemName=robertohuertasm.vscode-icons) - Icons for Visual Studio Code
* [vscode-spotify](https://marketplace.visualstudio.com/items?itemName=shyykoserhiy.vscode-spotify) - Use Spotify inside vscode.

Here's the bookmarklet I used to quickly generate these blurbs:

```javascript
javascript: (function() {
  var url = window.location.href;
  var name = document.querySelector("span.ux-item-name").innerText;
  var description = document.querySelector("div.ux-item-shortdesc").innerText;
  window.prompt("Copy to Clipboard: CMD/Ctrl+c, Enter", `[${name}](${url}) - ${description}`);
})();
```

Just stick that in a bookmark and it'll generate quick-and-dirty blurbs for VSC Extensions from their marketplace pages online.
